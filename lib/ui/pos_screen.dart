import 'package:flutter/material.dart';
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
        actions: const [],
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
