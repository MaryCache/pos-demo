import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../domain/product.dart';
import '../../state/catalog_model.dart';
import '../../state/register_model.dart';

/// 整数の円額を3桁区切りの表示文字列にする（例: -1234 → "-¥1,234"）。
/// 共通の金額表示ヘルパとしてここに置き、各 UI から `show yen` で取り込む（intl 非依存）。
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

  /// カテゴリ選択チップ。
  /// 既製の ChoiceChip は CJK ラベルで intrinsic 幅計算が詰まり、文字が1〜2文字に
  /// クランプされて右が見切れる挙動が出ることがある（CanvasKit + Material3 の組合せで顕在化）。
  /// 自作で Material+InkWell+Padding+Text に置き換えることで、Text が自分の intrinsic
  /// 幅にきちんとサイズされ、CJK でも崩れない。
  Widget _categoryChip(String label, bool selected, VoidCallback onTap) {
    final scheme = Theme.of(context).colorScheme;
    final base = Theme.of(context).textTheme.labelLarge ?? const TextStyle(fontSize: 14);
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: Material(
        color: selected ? scheme.secondaryContainer : scheme.surface,
        shape: StadiumBorder(
          side: BorderSide(
            color: selected ? Colors.transparent : scheme.outline,
          ),
        ),
        child: InkWell(
          onTap: onTap,
          customBorder: const StadiumBorder(),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
            child: Text(
              label,
              style: base.copyWith(
                color: selected ? scheme.onSecondaryContainer : scheme.onSurfaceVariant,
                fontWeight: selected ? FontWeight.w600 : FontWeight.w500,
              ),
            ),
          ),
        ),
      ),
    );
  }

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
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            child: Row(
              children: [
                _categoryChip('全部', _selectedCategory == null,
                    () => setState(() => _selectedCategory = null)),
                // カテゴリごとのチップ（出現順を保持）
                for (final category in byCategory.keys)
                  _categoryChip(category, _selectedCategory == category,
                      () => setState(() => _selectedCategory = category)),
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
