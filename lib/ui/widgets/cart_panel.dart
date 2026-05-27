import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../state/register_model.dart';
import '../payment_dialog.dart';
import 'cart_line_tile.dart';
import 'totals_panel.dart';

/// 右ペイン：明細リスト＋合計＋全体値引き／会計ボタン。
class CartPanel extends StatelessWidget {
  const CartPanel({super.key});

  @override
  Widget build(BuildContext context) {
    final register = context.watch<RegisterModel>();
    final lines = register.lines;
    final receipt = register.receiptFor(0);

    return Column(
      children: [
        Expanded(
          child: lines.isEmpty
              ? const Center(child: Text('商品を選んでください'))
              : ListView.separated(
                  itemCount: lines.length,
                  separatorBuilder: (_, _) => const Divider(height: 1),
                  itemBuilder: (_, i) => CartLineTile(index: i, line: lines[i]),
                ),
        ),
        Material(
          elevation: 8,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                TotalsPanel(receipt: receipt),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton.icon(
                        onPressed: lines.isEmpty
                            ? null
                            : () => editOrderDiscount(context, context.read<RegisterModel>()),
                        icon: const Icon(Icons.discount_outlined),
                        label: const Text('全体値引き'),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: FilledButton.icon(
                        onPressed: lines.isEmpty ? null : () => openPaymentDialog(context),
                        icon: const Icon(Icons.payments_outlined),
                        label: const Text('会計'),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
