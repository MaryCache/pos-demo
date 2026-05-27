import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../domain/product.dart';
import '../state/catalog_model.dart';
import 'product_edit_dialog.dart';
import 'widgets/product_grid.dart' show yen;

/// 商品マスタの追加・編集・削除画面。
class ProductAdminView extends StatelessWidget {
  const ProductAdminView({super.key});

  @override
  Widget build(BuildContext context) {
    final catalog = context.watch<CatalogModel>();
    final products = catalog.products;
    return Scaffold(
      appBar: AppBar(title: const Text('商品管理')),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          final p = await showProductEditDialog(context);
          if (p != null) await catalog.add(p);
        },
        icon: const Icon(Icons.add),
        label: const Text('追加'),
      ),
      body: ListView.separated(
        itemCount: products.length,
        separatorBuilder: (context, index) => const Divider(height: 1),
        itemBuilder: (_, i) {
          final p = products[i];
          return ListTile(
            title: Text(p.name),
            subtitle: Text('${p.category}・${p.taxRate}%'),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(yen(p.unitPriceExclTax)),
                IconButton(
                  icon: const Icon(Icons.edit_outlined),
                  onPressed: () async {
                    final edited = await showProductEditDialog(context, editing: p);
                    if (edited != null) await catalog.edit(edited);
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.delete_outline),
                  onPressed: () => _confirmDelete(context, catalog, p),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Future<void> _confirmDelete(BuildContext context, CatalogModel catalog, Product p) async {
    final ok = await showDialog<bool>(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('削除確認'),
        content: Text('「${p.name}」を削除しますか？（過去の売上記録は残ります）'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context, false), child: const Text('キャンセル')),
          FilledButton(onPressed: () => Navigator.pop(context, true), child: const Text('削除')),
        ],
      ),
    );
    if (ok == true) await catalog.remove(p.id!);
  }
}
