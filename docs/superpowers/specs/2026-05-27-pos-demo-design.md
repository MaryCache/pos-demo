# POS レジシステム デモ 設計書

最終更新: 2026-05-27
対象: `~/projects/pos-demo/`（Flutter Web デモ）
ステータス: 設計確定（ブレインストーミング承認済み・SQLite永続化を反映）

## 1. 目的とスコープ

汎用（業態非依存）の POS レジを Flutter Web で動かすデモ。会計ロジックが実際に
動作し、データは **SQLite（drift / ブラウザ内 WASM）に永続化**する（再起動後も残る）。
人に見せて「レジ打ち→会計→お釣り→レシート」と「商品マスタ管理」「売上集計」が
一通り動くことを示すのが目的。

### やること（IN）
- 商品マスタの **CRUD UI**（追加・編集・削除）。DB 管理。
- サンプル商品の **初回シード**（DB が空なら投入）
- レジ打ち（タップで明細追加・数量増減・明細削除）
- 軽減税率 8% / 10% の税率別集計
- 値引き：単品（明細単位）＋ 全体（税率グループへ按分）
- 現金会計：預かり金入力 → お釣り計算
- レシート表示（明細・税率別・合計・預かり・お釣り）
- **会計確定で売上を DB 保存**。売上集計（件数・合計・税率別）を DB から表示。
- **カート退避**：カート変更を DB に逐次保存し、起動時に復元。

### やらないこと（OUT / YAGNI）
- 現金以外の決済（カード・電子マネー等）
- ログイン・複数レジ・在庫管理・返品処理
- 多言語・通貨切替（日本円固定）
- サーバDB／同期（DB はブラウザ内ローカルのみ）

## 2. ターゲットと技術選定
- プラットフォーム: Web（`flutter run -d chrome`）。横長2ペイン前提。
- 状態管理: `provider`（`ChangeNotifier`）。公式標準で読みやすくデモ向き。
- 永続化: **drift**（sqlite3 WASM）。Web を正式サポート、型安全クエリ、マイグレーション容易。
  - 依存: `drift`, `sqlite3`, `path_provider`(非web向け保険) / dev: `drift_dev`, `build_runner`
  - Web 用に `web/sqlite3.wasm` と drift worker を配置（drift の web セットアップ手順に従う）。
    DB 実体はブラウザの永続ストレージ（IndexedDB/OPFS）に保存される。
- 見た目: Material 3。タッチ最適化（大きめタップ領域）。過剰装飾はしない。
- 会計ロジックは Flutter/DB 非依存の純粋 Dart に隔離し、TDD でユニットテスト。

## 3. レイヤー構成

```
lib/
  domain/        純粋 Dart・Flutter/DB 非依存・テスト対象
    product.dart        Product(id, name, unitPriceExclTax, taxRate, category)
    cart_line.dart      CartLine(product, quantity, lineDiscount)
    discount.dart       Discount(種類: 金額 or 率, 値)
    register_calc.dart  ★純粋関数群（§5 の計算ルール）
    receipt.dart        Receipt / TaxGroupSummary（計算結果のスナップショット）
    sale_record.dart    SaleRecord（確定会計のドメイン表現）
  data/          永続化層（drift）。domain との変換はここで吸収
    database.dart       drift Database 定義（テーブル・DAO）＋ web 用 open
    database.g.dart     ← build_runner 生成（コミット対象外/対象は方針に従う）
    tables.dart         テーブル定義（Products / Sales / SaleLines / SaleTaxGroups / DraftCart...）
    product_repository.dart  商品 CRUD・watch
    sales_repository.dart    会計保存（トランザクション）・集計取得
    cart_repository.dart     カート退避の保存/復元/クリア
    mappers.dart        drift row ⇔ domain モデル変換
  state/
    catalog_model.dart  ChangeNotifier。商品一覧の購読＋ CRUD（ProductRepository 経由）
    register_model.dart ChangeNotifier。カート操作＋会計確定。計算は register_calc、
                        永続化は CartRepository / SalesRepository へ委譲
  data/seed.dart        初回シード用サンプル商品 12〜16 点（食品=8% / 日用品・酒=10%）
  ui/
    app.dart            Provider 配線・初期化ローディング
    pos_screen.dart           2ペイン: 左=商品グリッド / 右=カート＋合計
    payment_dialog.dart       預かり金入力 → お釣り表示 → 確定
    receipt_view.dart         明細レシートのモーダル
    sales_summary_view.dart   売上集計(件数・合計・税率別、DB から)
    product_admin_view.dart   商品マスタ CRUD 画面
    product_edit_dialog.dart  商品の追加/編集フォーム
    widgets/
      product_grid.dart
      cart_panel.dart
      cart_line_tile.dart
      totals_panel.dart
  main.dart           DB 初期化 → シード → runApp
test/
  register_calc_test.dart     純粋関数のユニットテスト
  (任意) repository テスト       drift の in-memory(NativeDatabase.memory) で CRUD/集計
```

### ユニット境界
- `register_calc`: 入力（明細＋全体値引き＋預かり金）→ 出力（`Receipt`）。状態を持たない
  純粋関数。UI/状態/DB から独立してテスト可能。
- Repository 群: DB アクセスを drift に閉じ込め、上位には domain モデルだけを渡す。
- `RegisterModel`: カート状態を保持し、操作のたびに `register_calc` で再計算し
  `CartRepository` に退避、`notifyListeners`。会計確定で `SalesRepository` に保存。
  **計算ロジックも SQL も持たない**（純粋関数と Repository へ委譲）。
- `CatalogModel`: `ProductRepository` を購読し商品一覧を公開、CRUD を仲介。
- UI ウィジェット: モデルを `context.watch` で購読し描画。ロジックなし。

## 4. ドメインモデル
- `Product`: `id:int`(DB採番), `name:String`, `unitPriceExclTax:int`(税抜・円),
  `taxRate:int`(8 または 10), `category:String`
- `CartLine`: `product:Product`, `quantity:int`, `lineDiscount:Discount?`
- `Discount`: `type:{amount, percent}`, `value:int`（amount=円 / percent=整数%）
- `Receipt`: `lines`, `groups:List<TaxGroupSummary>`, `discountTotal:int`,
  `grandTotal:int`, `tendered:int`, `change:int`, `timestamp`
- `TaxGroupSummary`: `rate:int`, `taxableExclTax:int`(値引後税抜), `tax:int`
- `SaleRecord`: 確定 `Receipt` ＋ DB id。集計・履歴表示に使う

## 5. 会計計算ルール（register_calc の仕様）

金額はすべて整数（円）。丸めは明示する。

1. **明細税抜額**: `lineExcl = product.unitPriceExclTax * quantity`
2. **単品値引き適用**:
   - amount: `lineExcl - value`（下限 0）
   - percent: `lineExcl - floor(lineExcl * value / 100)`
   → `lineExclAfter`
3. **税率グループ小計**: 税率(8/10)ごとに `lineExclAfter` を合計 → `Sg`
4. **全体値引きの按分**: 全体値引き `D`（円。percent は `D = floor(totalExcl * value / 100)`,
   `totalExcl = ΣSg`）を各グループへ按分。
   - `Dg = floor(D * Sg / totalExcl)`
   - 端数（`D - ΣDg`）は **Sg が最大のグループ**へ加算（ΣDg == D を保証）
   - `totalExcl == 0` のときは値引きなし
5. **グループ課税ベース**: `baseG = Sg - Dg`（下限 0）
6. **グループ税額**: `taxG = floor(baseG * rate / 100)`（1円未満切り捨て）
7. **合計**: `grandTotal = Σ baseG + Σ taxG`
8. **お釣り**: `change = tendered - grandTotal`
   - `tendered < grandTotal` は会計不可（UI で確定無効＋不足表示）

### テスト境界
- 税率混在の税率別集計／単品値引き(amount,percent切り捨て)／全体値引き按分(端数が最大
  グループへ寄る・ΣDg==D)／税額1円未満切り捨て／お釣り(ちょうど・過不足)／空カート／
  全体値引きが小計超過(下限0)

## 6. DB スキーマ（drift テーブル）

会計記録は商品の後からの変更・削除に影響されないよう **スナップショットで保存**する。

- `products`: `id PK auto`, `name`, `unit_price_excl_tax`, `tax_rate`, `category`
- `sales`: `id PK auto`, `created_at`(epoch ms), `discount_total`, `grand_total`,
  `tendered`, `change`
- `sale_lines`: `id PK auto`, `sale_id FK`, `product_name`(snapshot),
  `unit_price_excl_tax`(snapshot), `tax_rate`(snapshot), `quantity`,
  `line_discount_type`?, `line_discount_value`?, `line_excl_after`
- `sale_tax_groups`: `id PK auto`, `sale_id FK`, `rate`, `taxable_excl_tax`, `tax`
- `draft_cart_lines`: `id PK auto`, `product_id FK`, `quantity`,
  `line_discount_type`?, `line_discount_value`?, `sort_order`
- `draft_meta`(単一行): `id PK(=1)`, `order_discount_type`?, `order_discount_value`?

マイグレーション: 初版 `schemaVersion = 1`。将来変更時に drift のマイグレーション手順で対応。

## 7. リポジトリ API（抜粋）
- `ProductRepository`: `watchAll() : Stream<List<Product>>`, `add(Product)`,
  `update(Product)`, `delete(int id)`, `count()`
- `SalesRepository`: `save(Receipt) : Future<int>`（sales＋sale_lines＋sale_tax_groups を
  1トランザクションで挿入、sale id を返す）, `watchAll()`, `summary()`(件数・合計・税率別)
- `CartRepository`: `loadDraft() : Future<(List<CartLine>, Discount?)>`,
  `upsertLine`, `removeLine`, `setOrderDiscount`, `clear()`
  - `draft_cart_lines.product_id` が削除済み商品を指す場合、復元時にその行はスキップ

## 8. 状態と操作

### CatalogModel（ChangeNotifier）
- `ProductRepository.watchAll()` を購読し `List<Product>` を公開
- `addProduct / editProduct / deleteProduct`（Repository へ委譲）

### RegisterModel（ChangeNotifier）
保持: `List<CartLine> lines`, `Discount? orderDiscount`, 計算結果 `Receipt`
- 初期化: `CartRepository.loadDraft()` でカート復元
- 操作（毎回 `register_calc` 再計算 → `CartRepository` に退避 → `notifyListeners`）:
  `addProduct(Product)`(同一商品は数量+1) / `changeQuantity(index, delta)`(0で削除) /
  `removeLine(index)` / `setLineDiscount(index, Discount?)` / `setOrderDiscount(Discount?)`
- `currentReceipt(tendered)`: プレビュー計算（純粋関数呼び出し）
- `checkout(tendered)`: `Receipt` 確定 → `SalesRepository.save` → `CartRepository.clear`
  → カート/値引きクリア → 確定 `Receipt` を返す（レシート表示用）

## 9. アプリ起動と非同期初期化（main / app）
1. `main()`: Flutter 初期化 → drift Web DB を `await` で open
2. `products` が空なら `seed.dart` のサンプル商品を投入（初回のみ）
3. Repository を生成し `Provider` で配線、`CartRepository.loadDraft()` で `RegisterModel` 復元
4. 初期化中はローディング表示。完了後 `pos_screen` を表示

## 10. データフロー

```
商品タップ → RegisterModel.addProduct → lines 更新 → register_calc 再計算
  → CartRepository に退避 → notifyListeners → カート/合計パネル再描画

会計 → PaymentDialog(預かり金) → RegisterModel.checkout(tendered)
  → SalesRepository.save(トランザクション) → CartRepository.clear
  → ReceiptView 表示 → 売上集計に反映

商品管理 → ProductAdminView → CatalogModel.add/edit/delete
  → ProductRepository → products テーブル更新 → watchAll で一覧/グリッド更新
```

## 11. UI 構成（Material 3 / タッチ最適化）
- **POS メイン（pos_screen）**: 横長2ペイン。左=商品グリッド（カテゴリフィルタ、
  タップで明細追加）／右=カート（明細・数量±・単品値引き）＋合計パネル
  （税率別小計/税額・値引き・合計）＋「全体値引き」「会計」。AppBar に「売上集計」「商品管理」。
- **PaymentDialog**: 数字キーパッドで預かり金入力 → お釣りをリアルタイム表示。
  不足時は確定無効＋不足額。よく使う金額（ちょうど/1000/5000/10000）ボタン。
- **ReceiptView**: 明細・税率別・合計・預かり・お釣り。
- **SalesSummaryView**: DB の売上を集計（件数・合計・税率別内訳）。一覧も表示。
- **ProductAdminView / ProductEditDialog**: 商品の追加・編集・削除フォーム。

## 12. テスト方針
- `register_calc` を TDD で先に固める（§5 のテスト境界）。`flutter test`。
- 任意で Repository を drift `NativeDatabase.memory()` でテスト（CRUD・売上集計・按分保存）。
- UI は手動確認（`flutter run -d chrome`）。必要なら軽量ウィジェットテスト。

## 13. 検証
- `flutter test` 緑。
- `flutter run -d chrome` で: 商品管理で追加/編集/削除 → レジ打ち → 値引き → 会計 →
  お釣り → レシート → 売上集計、までの一連が動く。
- **リロードしてもデータ（商品・売上・退避カート）が残る**ことを確認。
- WSL から Windows 側 flutter を呼ぶため、web の drift WASM 配置・build_runner 生成・
  Chrome 起動を実装初期に確認する（ここが本案の技術的リスク）。

## 14. 既知の単純化（デモゆえの割り切り）
- DB はブラウザ内ローカルのみ（サーバ同期なし）。別ブラウザ/端末では共有されない。
- 現金のみ。
- 端数処理は「税率グループ単位の1円未満切り捨て」固定（事業者により異なるが一般的方式）。
- 会計記録は商品スナップショット保存のため、後から商品を編集/削除しても過去の売上は不変。
