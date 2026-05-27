import 'cart_line.dart';
import 'discount.dart';
import 'receipt.dart';

/// 明細の税抜額 [lineExcl] に単品値引きを適用した結果（下限0）。
/// percent は 1円未満切り捨て。
int applyLineDiscount(int lineExcl, Discount? d) {
  if (d == null) return lineExcl;
  final cut = switch (d.type) {
    DiscountType.amount => d.value,
    DiscountType.percent => lineExcl * d.value ~/ 100,
  };
  final result = lineExcl - cut;
  return result < 0 ? 0 : result;
}

/// 全体値引き [orderDiscountAmount]（円）を、税率グループ別の税抜小計 [subtotals] に
/// 比例配分する。端数は小計が最大のグループへ寄せ、配分合計が値引き額に一致するようにする。
Map<int, int> distributeOrderDiscount(Map<int, int> subtotals, int orderDiscountAmount) {
  final total = subtotals.values.fold(0, (a, b) => a + b);
  if (orderDiscountAmount <= 0 || total <= 0) {
    return {for (final r in subtotals.keys) r: 0};
  }
  final alloc = <int, int>{};
  var allocated = 0;
  for (final e in subtotals.entries) {
    final d = orderDiscountAmount * e.value ~/ total;
    alloc[e.key] = d;
    allocated += d;
  }
  final remainder = orderDiscountAmount - allocated;
  if (remainder != 0) {
    final maxRate = subtotals.entries.reduce((a, b) => a.value >= b.value ? a : b).key;
    alloc[maxRate] = alloc[maxRate]! + remainder;
  }
  return alloc;
}

/// カート明細・全体値引き・預かり金から会計結果 [Receipt] を計算する純粋関数。
/// 仕様: 単品値引き→税率グループ別小計→全体値引きの比例按分→グループ別1円未満切り捨て課税。
Receipt computeReceipt({
  required List<CartLine> lines,
  required Discount? orderDiscount,
  required int tendered,
  DateTime? timestamp,
}) {
  // 1. 明細ごとに単品値引き適用
  final receiptLines = <ReceiptLine>[];
  var lineDiscountSum = 0;
  final subtotals = <int, int>{}; // rate -> 値引後税抜合計
  for (final line in lines) {
    final lineExcl = line.product.unitPriceExclTax * line.quantity;
    final after = applyLineDiscount(lineExcl, line.lineDiscount);
    lineDiscountSum += lineExcl - after;
    subtotals.update(line.product.taxRate, (v) => v + after, ifAbsent: () => after);
    receiptLines.add(ReceiptLine(
      productName: line.product.name,
      unitPriceExclTax: line.product.unitPriceExclTax,
      taxRate: line.product.taxRate,
      quantity: line.quantity,
      lineDiscount: line.lineDiscount,
      lineExclAfter: after,
    ));
  }

  // 2. 全体値引き額を算出（percent は税抜小計合計に対して切り捨て、amount は小計上限）
  final totalExcl = subtotals.values.fold(0, (a, b) => a + b);
  var orderDiscountAmount = 0;
  if (orderDiscount != null) {
    orderDiscountAmount = switch (orderDiscount.type) {
      DiscountType.amount => orderDiscount.value,
      DiscountType.percent => totalExcl * orderDiscount.value ~/ 100,
    };
    if (orderDiscountAmount > totalExcl) orderDiscountAmount = totalExcl;
    if (orderDiscountAmount < 0) orderDiscountAmount = 0;
  }

  // 3. 全体値引きをグループへ按分
  final alloc = distributeOrderDiscount(subtotals, orderDiscountAmount);

  // 4. グループ別課税ベースと税額（rate 昇順）
  final rates = subtotals.keys.toList()..sort();
  final groups = <TaxGroupSummary>[];
  var grandTotal = 0;
  for (final rate in rates) {
    final base = subtotals[rate]! - (alloc[rate] ?? 0);
    final taxable = base < 0 ? 0 : base;
    final tax = taxable * rate ~/ 100; // 1円未満切り捨て
    groups.add(TaxGroupSummary(rate: rate, taxableExclTax: taxable, tax: tax));
    grandTotal += taxable + tax;
  }

  return Receipt(
    lines: receiptLines,
    groups: groups,
    discountTotal: lineDiscountSum + orderDiscountAmount,
    grandTotal: grandTotal,
    tendered: tendered,
    change: tendered - grandTotal,
    timestamp: timestamp ?? DateTime.now(),
  );
}
