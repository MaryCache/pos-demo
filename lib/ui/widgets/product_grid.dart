import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../domain/product.dart';
import '../../state/catalog_model.dart';
import '../../state/register_model.dart';

/// 円表示のヘルパ（3桁区切り）。
String yen(int v) {
  final s = v.abs().toString();
  final buf = StringBuffer();
  for (var i = 0; i < s.length; i++) {
    if (i > 0 && (s.length - i) % 3 == 0) buf.write(',');
    buf.write(s[i]);
  }
  return '${v < 0 ? '-' : ''}¥$buf';
}

/// 商品をタップでカートに追加するグリッド。カテゴリフィルタ付き。
/// byCategory を活用して未選択時は全商品、選択時はそのカテゴリのみを表示する。
class ProductGrid extends StatefulWidget {
  const ProductGrid({super.key});

  @override
  State<ProductGrid> createState() => _ProductGridState();
}

class _ProductGridState extends State<ProductGrid> {
  /// null = 全部、非null = 絞り込み中のカテゴリ名。
  String? _selectedCategory;

  @override
  Widget build(BuildContext context) {
    final catalog = context.watch<CatalogModel>();
    final register = context.read<RegisterModel>();
    final byCategory = catalog.byCategory;

    // 選択カテゴリが商品変更で消えた場合にリセット。
    if (_selectedCategory != null && !byCategory.containsKey(_selectedCategory)) {
      _selectedCategory = null;
    }

    final products = _selectedCategory == null
        ? catalog.products
        : (byCategory[_selectedCategory] ?? const []);

    return Column(
      children: [
        if (byCategory.isNotEmpty)
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            child: Row(
              children: [
                // 「全部」チップ
                Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: ChoiceChip(
                    label: const Text('全部'),
                    selected: _selectedCategory == null,
                    onSelected: (_) => setState(() => _selectedCategory = null),
                  ),
                ),
                // カテゴリごとのチップ（出現順を保持）
                for (final category in byCategory.keys)
                  Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: ChoiceChip(
                      label: Text(category),
                      selected: _selectedCategory == category,
                      onSelected: (_) => setState(() => _selectedCategory = category),
                    ),
                  ),
              ],
            ),
          ),
        Expanded(
          child: products.isEmpty
              ? Center(
                  child: Text(
                    _selectedCategory == null
                        ? '商品がありません。「商品管理」で追加してください'
                        : '「$_selectedCategory」の商品がありません',
                  ),
                )
              : GridView.builder(
                  padding: const EdgeInsets.fromLTRB(12, 0, 12, 12),
                  gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 180,
                    mainAxisExtent: 110,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                  ),
                  itemCount: products.length,
                  itemBuilder: (context, i) => _ProductCard(
                    product: products[i],
                    onTap: () => register.addProduct(products[i]),
                  ),
                ),
        ),
      ],
    );
  }
}

class _ProductCard extends StatelessWidget {
  final Product product;
  final VoidCallback onTap;
  const _ProductCard({required this.product, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Card(
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Text(product.name,
                    style: Theme.of(context).textTheme.titleSmall,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(yen(product.unitPriceExclTax),
                      style: Theme.of(context).textTheme.titleMedium),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                    decoration: BoxDecoration(
                      color: scheme.secondaryContainer,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Text('${product.taxRate}%',
                        style: Theme.of(context).textTheme.labelSmall),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
