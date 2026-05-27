import 'package:flutter/material.dart';
import '../../domain/receipt.dart';
import 'product_grid.dart' show yen;

/// 税率別小計・税額・値引き・合計を表示する。
class TotalsPanel extends StatelessWidget {
  final Receipt receipt;
  const TotalsPanel({super.key, required this.receipt});

  @override
  Widget build(BuildContext context) {
    final t = Theme.of(context).textTheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.min,
      children: [
        for (final g in receipt.groups)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 2),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('${g.rate}% 対象 ${yen(g.taxableExclTax)}'),
                Text('税 ${yen(g.tax)}'),
              ],
            ),
          ),
        if (receipt.discountTotal > 0)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 2),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('値引き合計'),
                Text('-${yen(receipt.discountTotal)}',
                    style: TextStyle(color: Theme.of(context).colorScheme.error)),
              ],
            ),
          ),
        const Divider(),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('合計', style: t.titleLarge),
            Text(yen(receipt.grandTotal), style: t.titleLarge),
          ],
        ),
      ],
    );
  }
}
