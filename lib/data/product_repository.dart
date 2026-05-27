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

  /// 商品を1件追加し、採番された id を返す。
  Future<int> add(Product p) => db.into(db.products).insert(toProductsCompanion(p));

  /// 既存商品を id 一致で上書き更新する（p.id 必須）。
  Future<void> update(Product p) =>
      (db.update(db.products)..where((t) => t.id.equals(p.id!))).write(toProductsCompanion(p));

  /// 商品を1件削除する。過去の売上明細はスナップショットなので影響しない。
  Future<void> delete(int id) => (db.delete(db.products)..where((t) => t.id.equals(id))).go();

  /// 登録商品の件数。シード投入要否の判定に使う。
  Future<int> count() async {
    final c = db.products.id.count();
    final row = await (db.selectOnly(db.products)..addColumns([c])).getSingle();
    return row.read(c) ?? 0;
  }
}
