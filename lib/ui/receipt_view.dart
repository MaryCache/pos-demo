import 'package:flutter/material.dart';
import '../domain/receipt.dart';
import 'widgets/product_grid.dart' show yen;

/// 確定レシートをモーダル表示する。
Future<void> showReceipt(BuildContext context, Receipt receipt) async {
  await showDialog(
    context: context,
    builder: (_) => _ReceiptDialog(receipt: receipt),
  );
}

class _ReceiptDialog extends StatelessWidget {
  final Receipt receipt;
  const _ReceiptDialog({required this.receipt});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('レシート'),
      content: SizedBox(
        width: 360,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: [
              for (final l in receipt.lines)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 2),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(child: Text('${l.productName} ×${l.quantity}')),
                      Text(yen(l.lineExclAfter)),
                    ],
                  ),
                ),
              const Divider(),
              for (final g in receipt.groups)
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('${g.rate}% 対象 ${yen(g.taxableExclTax)}'),
                    Text('税 ${yen(g.tax)}'),
                  ],
                ),
              if (receipt.discountTotal > 0)
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('値引き合計'),
                    Text('-${yen(receipt.discountTotal)}'),
                  ],
                ),
              const Divider(),
              _big(context, '合計', yen(receipt.grandTotal)),
              _line(context, '預かり', yen(receipt.tendered)),
              _big(context, 'お釣り', yen(receipt.change)),
            ],
          ),
        ),
      ),
      actions: [
        FilledButton(onPressed: () => Navigator.pop(context), child: const Text('閉じる')),
      ],
    );
  }

  Widget _line(BuildContext context, String label, String value) => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [Text(label), Text(value)],
      );

  Widget _big(BuildContext context, String label, String value) {
    final style = Theme.of(context).textTheme.titleLarge;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [Text(label, style: style), Text(value, style: style)],
    );
  }
}
