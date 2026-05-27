import 'package:drift/drift.dart';
import '../domain/product.dart';
import 'database.dart';
import 'mappers.dart';

/// 商品マスタの永続化。
class ProductRepository {
  final AppDatabase db;
  ProductRepository(this.db);

  /// 商品一覧を id 昇順で購読する。
  Stream<List<Product>> watchAll() {
    final query = db.select(db.products)..orderBy([(t) => OrderingTerm(expression: t.id)]);
    return query.watch().map((rows) => rows.map(toProduct).toList());
  }

  Future<int> add(Product p) => db.into(db.products).insert(toProductsCompanion(p));

  Future<void> update(Product p) =>
      (db.update(db.products)..where((t) => t.id.equals(p.id!))).write(toProductsCompanion(p));

  Future<void> delete(int id) => (db.delete(db.products)..where((t) => t.id.equals(id))).go();

  Future<int> count() async {
    final c = db.products.id.count();
    final row = await (db.selectOnly(db.products)..addColumns([c])).getSingle();
    return row.read(c) ?? 0;
  }
}
