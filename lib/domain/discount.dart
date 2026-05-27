/// 値引きの種類。amount=円、percent=整数パーセント。
enum DiscountType { amount, percent }

/// 単品・全体に適用する値引き。
class Discount {
  final DiscountType type;

  /// type=amount なら円、percent なら整数パーセント（例: 10 = 10%）。
  final int value;
  const Discount(this.type, this.value);
}
