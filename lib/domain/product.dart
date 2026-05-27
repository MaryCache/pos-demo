/// 商品マスタの1件。価格は税抜（円）。taxRate は 8 または 10。
class Product {
  /// DB 採番の ID。未保存のときは null。
  final int? id;
  final String name;
  final int unitPriceExclTax;
  final int taxRate;
  final String category;

  const Product({
    this.id,
    required this.name,
    required this.unitPriceExclTax,
    required this.taxRate,
    required this.category,
  });

  Product copyWith({int? id, String? name, int? unitPriceExclTax, int? taxRate, String? category}) {
    return Product(
      id: id ?? this.id,
      name: name ?? this.name,
      unitPriceExclTax: unitPriceExclTax ?? this.unitPriceExclTax,
      taxRate: taxRate ?? this.taxRate,
      category: category ?? this.category,
    );
  }
}
