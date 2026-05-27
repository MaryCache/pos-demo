# POS レジシステム デモ 設計書

最終更新: 2026-05-27
対象: `~/projects/pos-demo/`（Flutter Web デモ）
ステータス: 設計確定（ブレインストーミング承認済み）

## 1. 目的とスコープ

汎用（業態非依存）の POS レジを Flutter Web で動かすデモ。会計ロジックは
メモリ上で実際に動作する（再起動でデータは消える＝永続化しない）。
人に見せて「レジ打ち→会計→お釣り→レシート」が一通り動くことを示すのが目的。

### やること（IN）
- サンプル商品カタログからのレジ打ち（タップで明細追加・数量増減・明細削除）
- 軽減税率 8% / 10% の税率別集計
- 値引き：単品（明細単位）＋ 全体（税率グループへ按分）
- 現金会計：預かり金入力 → お釣り計算
- レシート表示（明細・税率別・合計・預かり・お釣り）
- セッション売上集計（件数・合計、メモリ上）

### やらないこと（OUT / YAGNI）
- 永続化（DB・ファイル保存）。再起動で消える
- カード/電子マネー等、現金以外の決済
- 商品マスタの編集 UI（カタログはコード内サンプル固定）
- ログイン・複数レジ・在庫管理・返品処理
- 多言語・通貨切替（日本円固定）

## 2. ターゲットと技術選定
- プラットフォーム: Web（`flutter run -d chrome`）。横長2ペイン前提。
- 状態管理: `provider`（`ChangeNotifier`）。公式標準で読みやすくデモ向き。
- 見た目: Material 3。タッチ最適化（大きめタップ領域）。過剰装飾はしない。
- 会計ロジックは Flutter 非依存の純粋 Dart に隔離し、TDD でユニットテスト。

## 3. レイヤー構成

```
lib/
  domain/        純粋 Dart・Flutter 非依存・テスト対象
    product.dart        Product(id, name, unitPriceExclTax, taxRate, category)
    cart_line.dart      CartLine(product, quantity, lineDiscount)
    discount.dart       Discount(値引きの種類: 金額 or 率, 値)
    register_calc.dart  ★純粋関数群（後述の計算ルール）
    receipt.dart        Receipt / TaxGroupSummary（計算結果のスナップショット）
    sale_record.dart    SaleRecord（1会計の記録・セッション集計用）
  state/
    register_model.dart RegisterModel extends ChangeNotifier
  data/
    sample_catalog.dart サンプル商品 12〜16 点（食品=8% / 日用品・酒=10% 混在）
  ui/
    pos_screen.dart           2ペイン: 左=商品グリッド / 右=カート＋合計
    payment_dialog.dart       預かり金入力 → お釣り表示 → 確定
    receipt_view.dart         明細レシートのモーダル
    sales_summary_view.dart   セッション売上(件数・合計)
    widgets/
      product_grid.dart
      cart_panel.dart
      cart_line_tile.dart
      totals_panel.dart
  main.dart
test/
  register_calc_test.dart     純粋関数のユニットテスト
```

### ユニット境界
- `register_calc`: 入力（明細リスト＋全体値引き＋預かり金）→ 出力（`Receipt`）。
  状態を持たない純粋関数。UI/状態層から独立してテスト可能。
- `RegisterModel`: 操作（追加/数量変更/値引き/会計確定）を受けて内部の明細を
  更新し、`register_calc` を呼んで `Receipt` を再計算、`notifyListeners`。
  **計算ロジックそのものは持たない**（`register_calc` へ委譲）。
- UI ウィジェット: `RegisterModel` を `context.watch` で購読し描画。ロジックなし。

## 4. データモデル

- `Product`: `id:String`, `name:String`, `unitPriceExclTax:int`(税抜・円),
  `taxRate:int`(8 または 10), `category:String`
- `CartLine`: `product:Product`, `quantity:int`, `lineDiscount:Discount?`
- `Discount`: `type:{amount, percent}`, `value:int`
  - amount = 円、percent = パーセント（整数）
- `Receipt`: `lines`, `groups:List<TaxGroupSummary>`, `discountTotal:int`,
  `grandTotal:int`, `tendered:int`, `change:int`, `timestamp`
- `TaxGroupSummary`: `rate:int`, `taxableExclTax:int`(値引後税抜), `tax:int`
- `SaleRecord`: `receipt` の確定スナップショット（セッション履歴へ push）

## 5. 会計計算ルール（register_calc の仕様）

金額はすべて整数（円）で扱う。丸めは明示する。

1. **明細税抜額**: `lineExcl = product.unitPriceExclTax * quantity`
2. **単品値引き適用**:
   - amount: `lineExcl - value`（下限 0）
   - percent: `lineExcl - floor(lineExcl * value / 100)`
   結果を `lineExclAfter` とする。
3. **税率グループ小計**: 税率(8/10)ごとに `lineExclAfter` を合計 → `Sg`
4. **全体値引きの按分**: 全体値引き `D`（円。percent の場合は
   `D = floor(totalExcl * value / 100)`, `totalExcl = ΣSg`）を各グループへ按分。
   - 各グループ配分 `Dg = floor(D * Sg / totalExcl)`
   - 端数（`D - ΣDg`）は **Sg が最大のグループ**へ加算（合計が D に一致するよう調整）
   - `totalExcl == 0` のときは値引きなし
5. **グループ課税ベース**: `baseG = Sg - Dg`（下限 0）
6. **グループ税額**: `taxG = floor(baseG * rate / 100)`（1円未満切り捨て）
7. **合計**: `grandTotal = Σ baseG + Σ taxG`
8. **お釣り**: `change = tendered - grandTotal`
   - `tendered < grandTotal` は会計不可（UI で確定ボタン無効＋不足表示）

### テスト対象の境界
- 税率混在（8% と 10% が両方ある）の税率別集計
- 単品値引き（amount / percent、percent の切り捨て）
- 全体値引きの按分（端数が最大グループへ寄る、ΣDg == D）
- 税額の 1円未満切り捨て
- お釣り（ちょうど・過不足）、空カート、全体値引きが小計を超える場合（下限0）

## 6. 状態と操作（RegisterModel）

保持する状態:
- `List<CartLine> lines`
- `Discount? orderDiscount`
- `List<SaleRecord> sessionSales`（セッション集計）

操作（いずれも最後に `register_calc` 再計算 → `notifyListeners`）:
- `addProduct(Product)`: 同一商品があれば数量+1、なければ明細追加
- `changeQuantity(lineIndex, delta)`: 数量増減、0 で明細削除
- `removeLine(lineIndex)`
- `setLineDiscount(lineIndex, Discount?)`
- `setOrderDiscount(Discount?)`
- `currentReceipt(tendered)`: 現在のカートから `Receipt` を計算（プレビュー用）
- `checkout(tendered)`: `Receipt` 確定 → `SaleRecord` を `sessionSales` に追加 →
  カートと値引きをクリア。確定した `Receipt` を返す（レシート表示用）

## 7. データフロー

```
商品タップ
  → RegisterModel.addProduct
  → lines 更新 → register_calc で Receipt 再計算
  → notifyListeners
  → CartPanel / TotalsPanel 再描画

会計ボタン → PaymentDialog（預かり金入力）
  → tendered 確定 → RegisterModel.checkout(tendered)
  → SaleRecord を sessionSales へ push → カートclear
  → ReceiptView をモーダル表示
```

## 8. UI 構成（Material 3 / タッチ最適化）

- **POS メイン画面（pos_screen）**: 横長2ペイン
  - 左ペイン: 商品グリッド（カテゴリでタブ or フィルタ、タップで明細追加）
  - 右ペイン: カート（明細リスト・数量 +/- ・単品値引きボタン）＋
    合計パネル（税率別小計/税額・値引き・合計）＋「全体値引き」「会計」ボタン
  - AppBar に「セッション売上」ボタン
- **PaymentDialog**: 預かり金を数字キーパッドで入力 → お釣りをリアルタイム表示。
  不足時は確定無効＋不足額表示。よく使う金額（ちょうど/1000/5000/10000）ボタン。
- **ReceiptView**: 確定レシートを明細・税率別・合計・預かり・お釣りで表示。
- **SalesSummaryView**: セッションの会計件数・売上合計（税率別内訳も）。

## 9. テスト方針
- `register_calc` を TDD で先に固める（§5 のテスト境界）。`flutter test`。
- UI は手動確認（`flutter run -d chrome`）。必要なら軽量ウィジェットテストを追加。

## 10. 検証
- `flutter test` 緑。
- `flutter run -d chrome` でレジ打ち→値引き→会計→お釣り→レシート→
  セッション集計の一連が動くことを目視確認。
- WSL から Windows 側 flutter を呼ぶため、web ビルド/Chrome 起動の動作は実装初期に確認する。

## 11. 既知の単純化（デモゆえの割り切り）
- 永続化なし（再起動で消える）。
- 商品マスタ固定。
- 現金のみ。
- 端数処理は「税率グループ単位の1円未満切り捨て」固定（事業者により異なるが一般的方式）。
