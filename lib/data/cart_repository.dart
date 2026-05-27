import 'package:drift/drift.dart';
import '../domain/cart_line.dart';
import '../domain/discount.dart';
import 'database.dart';
import 'mappers.dart';

/// 会計途中のカートを DB に退避し、起動時に復元する。
class CartRepository {
  final AppDatabase db;
  CartRepository(this.db);

  /// 退避カートを復元する。削除済み商品を指す行はスキップする。
  Future<(List<CartLine>, Discount?)> loadDraft() async {
    final rows = await (db.select(db.draftCartLines)
          ..orderBy([(t) => OrderingTerm(expression: t.sortOrder)]))
        .get();
    final lines = <CartLine>[];
    for (final row in rows) {
      final p = await (db.select(db.products)..where((t) => t.id.equals(row.productId)))
          .getSingleOrNull();
      if (p == null) continue; // 商品が削除済みなら捨てる
      lines.add(CartLine(
        product: toProduct(p),
        quantity: row.quantity,
        lineDiscount: discountFrom(row.lineDiscountType, row.lineDiscountValue),
      ));
    }
    final meta = await (db.select(db.draftMeta)..where((t) => t.id.equals(1))).getSingleOrNull();
    final orderDiscount =
        meta == null ? null : discountFrom(meta.orderDiscountType, meta.orderDiscountValue);
    return (lines, orderDiscount);
  }

  /// カート明細全体を上書き保存する（順序つき）。
  Future<void> replaceLines(List<CartLine> lines) async {
    await db.transaction(() async {
      await db.delete(db.draftCartLines).go();
      for (var i = 0; i < lines.length; i++) {
        final l = lines[i];
        await db.into(db.draftCartLines).insert(DraftCartLinesCompanion.insert(
              productId: l.product.id!,
              quantity: l.quantity,
              lineDiscountType: Value(discountTypeToText(l.lineDiscount?.type)),
              lineDiscountValue: Value(l.lineDiscount?.value),
              sortOrder: i,
            ));
      }
    });
  }

  /// 全体値引きを保存する（単一行 upsert）。
  Future<void> setOrderDiscount(Discount? d) async {
    await db.into(db.draftMeta).insertOnConflictUpdate(DraftMetaCompanion(
          id: const Value(1),
          orderDiscountType: Value(discountTypeToText(d?.type)),
          orderDiscountValue: Value(d?.value),
        ));
  }

  /// カートと全体値引きを全消去する（会計確定後）。
  Future<void> clear() async {
    await db.delete(db.draftCartLines).go();
    await (db.delete(db.draftMeta)..where((t) => t.id.equals(1))).go();
  }
}
