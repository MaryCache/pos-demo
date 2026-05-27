import '../domain/product.dart';
import 'product_repository.dart';

/// 食品=8% / 日用品・酒=10% を混在させたサンプル商品。
const List<Product> sampleProducts = [
  Product(name: 'おにぎり 鮭', unitPriceExclTax: 130, taxRate: 8, category: '食品'),
  Product(name: 'おにぎり 梅', unitPriceExclTax: 120, taxRate: 8, category: '食品'),
  Product(name: 'サンドイッチ', unitPriceExclTax: 280, taxRate: 8, category: '食品'),
  Product(name: '幕の内弁当', unitPriceExclTax: 580, taxRate: 8, category: '食品'),
  Product(name: '緑茶 500ml', unitPriceExclTax: 130, taxRate: 8, category: '飲料'),
  Product(name: 'コーヒー 微糖', unitPriceExclTax: 130, taxRate: 8, category: '飲料'),
  Product(name: 'チョコ菓子', unitPriceExclTax: 150, taxRate: 8, category: '菓子'),
  Product(name: 'ポテトチップス', unitPriceExclTax: 140, taxRate: 8, category: '菓子'),
  Product(name: '生ビール 350ml', unitPriceExclTax: 220, taxRate: 10, category: '酒'),
  Product(name: '缶チューハイ', unitPriceExclTax: 160, taxRate: 10, category: '酒'),
  Product(name: '台所洗剤', unitPriceExclTax: 250, taxRate: 10, category: '日用品'),
  Product(name: 'ティッシュ5箱', unitPriceExclTax: 320, taxRate: 10, category: '日用品'),
  Product(name: '乾電池 単3 4本', unitPriceExclTax: 380, taxRate: 10, category: '日用品'),
  Product(name: 'ボールペン', unitPriceExclTax: 100, taxRate: 10, category: '文具'),
];

/// 商品が1件も無ければサンプルを投入する（初回のみ）。
Future<void> seedIfEmpty(ProductRepository repo) async {
  if (await repo.count() > 0) return;
  for (final p in sampleProducts) {
    await repo.add(p);
  }
}
