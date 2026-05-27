import 'package:drift/drift.dart';

// drift の生成データクラス名が domain の Product 等と衝突しないよう Row サフィックスにする。

@DataClassName('ProductRow')
class Products extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text()();
  IntColumn get unitPriceExclTax => integer()();
  IntColumn get taxRate => integer()();
  TextColumn get category => text()();
}

@DataClassName('SaleRow')
class Sales extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get createdAt => integer()(); // epoch ms
  IntColumn get discountTotal => integer()();
  IntColumn get grandTotal => integer()();
  IntColumn get tendered => integer()();
  IntColumn get change => integer()();
}

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

@DataClassName('SaleTaxGroupRow')
class SaleTaxGroups extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get saleId => integer().references(Sales, #id)();
  IntColumn get rate => integer()();
  IntColumn get taxableExclTax => integer()();
  IntColumn get tax => integer()();
}

@DataClassName('DraftCartLineRow')
class DraftCartLines extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get productId => integer()();
  IntColumn get quantity => integer()();
  TextColumn get lineDiscountType => text().nullable()();
  IntColumn get lineDiscountValue => integer().nullable()();
  IntColumn get sortOrder => integer()();
}

@DataClassName('DraftMetaRow')
class DraftMeta extends Table {
  IntColumn get id => integer()(); // 固定で 1 を使う単一行
  TextColumn get orderDiscountType => text().nullable()();
  IntColumn get orderDiscountValue => integer().nullable()();
  @override
  Set<Column> get primaryKey => {id};
}
