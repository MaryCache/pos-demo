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
