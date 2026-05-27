import 'package:drift/drift.dart';
import '../domain/discount.dart';
import '../domain/product.dart';
import 'database.dart';

/// drift の ProductRow を domain Product に変換。
Product toProduct(ProductRow r) => Product(
      id: r.id,
      name: r.name,
      unitPriceExclTax: r.unitPriceExclTax,
      taxRate: r.taxRate,
      category: r.category,
    );

/// 新規挿入用 Companion（id は自動採番なので absent）。
ProductsCompanion toProductsCompanion(Product p) => ProductsCompanion(
      name: Value(p.name),
      unitPriceExclTax: Value(p.unitPriceExclTax),
      taxRate: Value(p.taxRate),
      category: Value(p.category),
    );

/// DiscountType を永続化用の文字列（enum 名）に変換。null は null のまま。
String? discountTypeToText(DiscountType? t) => t?.name;

/// 永続化文字列から DiscountType を復元。null は null のまま。
DiscountType? discountTypeFromText(String? s) =>
    s == null ? null : DiscountType.values.firstWhere((e) => e.name == s);

/// 文字列＋値から Discount を復元（両方ある時のみ）。
Discount? discountFrom(String? type, int? value) {
  final t = discountTypeFromText(type);
  if (t == null || value == null) return null;
  return Discount(t, value);
}
