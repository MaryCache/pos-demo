import 'package:drift/drift.dart';
import '../domain/receipt.dart';
import 'database.dart';
import 'mappers.dart';

/// 売上一覧の1行（軽量表示用）。
/// 重い Receipt 再構築をせず、一覧に必要な情報だけを保持する。
class SaleListItem {
  final int id;
  final DateTime time;
  final int grandTotal;
  final int change;
  const SaleListItem({
    required this.id,
    required this.time,
    required this.grandTotal,
    required this.change,
  });
}

/// 売上集計の結果。
class SalesSummary {
  final int count;            // 会計件数
  final int total;            // 税込合計
  final Map<int, int> taxByRate; // 税率 -> 税額合計
  const SalesSummary({required this.count, required this.total, required this.taxByRate});
}

/// 会計（売上）の永続化と集計。
class SalesRepository {
  final AppDatabase db;
  SalesRepository(this.db);

  /// 会計1件を sales / sale_lines / sale_tax_groups にトランザクションで保存し、sale id を返す。
  Future<int> save(Receipt r) {
    return db.transaction(() async {
      final saleId = await db.into(db.sales).insert(SalesCompanion.insert(
            createdAt: r.timestamp.millisecondsSinceEpoch,
            discountTotal: r.discountTotal,
            grandTotal: r.grandTotal,
            tendered: r.tendered,
            change: r.change,
          ));
      for (final line in r.lines) {
        await db.into(db.saleLines).insert(SaleLinesCompanion.insert(
              saleId: saleId,
              productName: line.productName,
              unitPriceExclTax: line.unitPriceExclTax,
              taxRate: line.taxRate,
              quantity: line.quantity,
              lineDiscountType: Value(discountTypeToText(line.lineDiscount?.type)),
              lineDiscountValue: Value(line.lineDiscount?.value),
              lineExclAfter: line.lineExclAfter,
            ));
      }
      for (final g in r.groups) {
        await db.into(db.saleTaxGroups).insert(SaleTaxGroupsCompanion.insert(
              saleId: saleId,
              rate: g.rate,
              taxableExclTax: g.taxableExclTax,
              tax: g.tax,
            ));
      }
      return saleId;
    });
  }

  /// 直近の会計を新しい順に購読する（一覧表示用）。
  Stream<List<SaleListItem>> watchRecent({int limit = 50}) {
    final query = db.select(db.sales)
      ..orderBy([(t) => OrderingTerm(expression: t.createdAt, mode: OrderingMode.desc)])
      ..limit(limit);
    return query.watch().map((rows) => rows
        .map((r) => SaleListItem(
              id: r.id,
              time: DateTime.fromMillisecondsSinceEpoch(r.createdAt),
              grandTotal: r.grandTotal,
              change: r.change,
            ))
        .toList());
  }

  /// 売上集計（件数・合計・税率別税額）を購読する。
  Stream<SalesSummary> watchSummary() {
    return db.select(db.sales).watch().asyncMap((sales) async {
      final count = sales.length;
      final total = sales.fold(0, (a, s) => a + s.grandTotal);
      final groups = await db.select(db.saleTaxGroups).get();
      final taxByRate = <int, int>{};
      for (final g in groups) {
        taxByRate.update(g.rate, (v) => v + g.tax, ifAbsent: () => g.tax);
      }
      return SalesSummary(count: count, total: total, taxByRate: taxByRate);
    });
  }
}
