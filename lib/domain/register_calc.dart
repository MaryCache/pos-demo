import 'discount.dart';

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
