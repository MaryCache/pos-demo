/// 値引きの種類。amount=円、percent=整数パーセント。
enum DiscountType { amount, percent }

/// 単品・全体に適用する値引き。
class Discount {
  final DiscountType type;
  final int value;
  const Discount(this.type, this.value);
}
