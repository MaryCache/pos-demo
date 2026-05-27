import 'package:drift/drift.dart';

// drift の生成データクラス名が domain の Product 等と衝突しないよう Row サフィックスにする。

/// 商品マスタ。価格は税抜（円）、taxRate は 8 または 10。
@DataClassName('ProductRow')
class Products extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text()();
  IntColumn get unitPriceExclTax => integer()();
  IntColumn get taxRate => integer()();
  TextColumn get category => text()();
}

/// 確定した会計1件のヘッダ（合計・値引き・預かり・釣り）。
@DataClassName('SaleRow')
class Sales extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get createdAt => integer()(); // epoch ms
  IntColumn get discountTotal => integer()();
  IntColumn get grandTotal => integer()();
  IntColumn get tendered => integer()();
  IntColumn get change => integer()();
}

/// 会計明細のスナップショット。商品名・価格・税率をコピー保持し、
/// 後から商品マスタを編集・削除しても過去の売上が変わらないようにする。
@DataClassName('SaleLineRow')
class SaleLines extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get saleId => integer().references(Sales, #id)();
  TextColumn get productName => text()();
  IntColumn get unitPriceExclTax => integer()();
  IntColumn get taxRate => integer()();
  IntColumn get quantity => integer()();
  TextColumn get lineDiscountType => text().nullable()();
  IntColumn get lineDiscountValue => integer().nullable()();
  IntColumn get lineExclAfter => integer()();
}

/// 会計の税率グループ別集計のスナップショット（売上集計の税額源）。
@DataClassName('SaleTaxGroupRow')
class SaleTaxGroups extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get saleId => integer().references(Sales, #id)();
  IntColumn get rate => integer()();
  IntColumn get taxableExclTax => integer()();
  IntColumn get tax => integer()();
}

/// 会計途中のカート明細を退避する下書きテーブル（リロード復元用）。
@DataClassName('DraftCartLineRow')
class DraftCartLines extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get productId => integer()();
  IntColumn get quantity => integer()();
  TextColumn get lineDiscountType => text().nullable()();
  IntColumn get lineDiscountValue => integer().nullable()();
  IntColumn get sortOrder => integer()();
}

/// 下書きカートの全体値引きを保持する単一行テーブル。
@DataClassName('DraftMetaRow')
class DraftMeta extends Table {
  IntColumn get id => integer()(); // 固定で 1 を使う単一行
  TextColumn get orderDiscountType => text().nullable()();
  IntColumn get orderDiscountValue => integer().nullable()();
  @override
  Set<Column> get primaryKey => {id};
}
