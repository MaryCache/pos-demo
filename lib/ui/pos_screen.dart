import 'package:flutter/material.dart';
import 'sales_summary_view.dart';
import 'widgets/cart_panel.dart';
import 'widgets/product_grid.dart';

/// レジのメイン画面。左=商品グリッド / 右=カート。
class PosScreen extends StatelessWidget {
  const PosScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('POS デモ'),
        actions: [
          IconButton(
            tooltip: '売上集計',
            icon: const Icon(Icons.bar_chart),
            onPressed: () => Navigator.of(context).push(
              MaterialPageRoute(builder: (_) => const SalesSummaryView()),
            ),
          ),
        ],
      ),
      body: Row(
        children: const [
          Expanded(flex: 3, child: ProductGrid()),
          VerticalDivider(width: 1),
          Expanded(flex: 2, child: CartPanel()),
        ],
      ),
    );
  }
}
