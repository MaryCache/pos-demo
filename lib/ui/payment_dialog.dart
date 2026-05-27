import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../domain/receipt.dart';
import '../state/register_model.dart';
import 'receipt_view.dart';
import 'widgets/product_grid.dart' show yen;

/// 会計ダイアログを開く。確定したらレシートを表示する。
Future<void> openPaymentDialog(BuildContext context) async {
  final register = context.read<RegisterModel>();
  final grandTotal = register.receiptFor(0).grandTotal;

  final receipt = await showDialog<Receipt>(
    context: context,
    builder: (_) => _PaymentDialog(register: register, grandTotal: grandTotal),
  );
  if (receipt != null && context.mounted) {
    await showReceipt(context, receipt);
  }
}

class _PaymentDialog extends StatefulWidget {
  final RegisterModel register;
  final int grandTotal;
  const _PaymentDialog({required this.register, required this.grandTotal});

  @override
  State<_PaymentDialog> createState() => _PaymentDialogState();
}

class _PaymentDialogState extends State<_PaymentDialog> {
  int _tendered = 0;

  void _append(int digit) => setState(() => _tendered = (_tendered * 10 + digit).clamp(0, 9999999));
  void _set(int v) => setState(() => _tendered = v);
  void _clear() => setState(() => _tendered = 0);

  @override
  Widget build(BuildContext context) {
    final change = _tendered - widget.grandTotal;
    final enough = change >= 0;
    final t = Theme.of(context).textTheme;

    return AlertDialog(
      title: const Text('会計'),
      content: SizedBox(
        width: 360,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _row('合計', yen(widget.grandTotal), t.titleMedium),
            const SizedBox(height: 4),
            _row('預かり', yen(_tendered), t.titleLarge),
            const Divider(),
            _row(
              enough ? 'お釣り' : '不足',
              yen(change.abs()),
              t.titleLarge!.copyWith(
                color: enough ? Colors.green.shade700 : Theme.of(context).colorScheme.error,
              ),
            ),
            const SizedBox(height: 12),
            Wrap(
              spacing: 8,
              children: [
                _quick('ちょうど', () => _set(widget.grandTotal)),
                _quick('¥1,000', () => _set(1000)),
                _quick('¥5,000', () => _set(5000)),
                _quick('¥10,000', () => _set(10000)),
              ],
            ),
            const SizedBox(height: 12),
            _keypad(),
          ],
        ),
      ),
      actions: [
        TextButton(onPressed: () => Navigator.pop(context), child: const Text('キャンセル')),
        FilledButton(
          onPressed: enough
              ? () async {
                  final receipt = await widget.register.checkout(_tendered);
                  if (context.mounted) Navigator.pop(context, receipt);
                }
              : null,
          child: const Text('確定'),
        ),
      ],
    );
  }

  Widget _row(String label, String value, TextStyle? style) => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [Text(label, style: style), Text(value, style: style)],
      );

  Widget _quick(String label, VoidCallback onTap) =>
      OutlinedButton(onPressed: onTap, child: Text(label));

  Widget _keypad() {
    final keys = ['1', '2', '3', '4', '5', '6', '7', '8', '9', 'C', '0', '⌫'];
    return GridView.count(
      shrinkWrap: true,
      crossAxisCount: 3,
      childAspectRatio: 1.8,
      mainAxisSpacing: 6,
      crossAxisSpacing: 6,
      physics: const NeverScrollableScrollPhysics(),
      children: keys.map((k) {
        return OutlinedButton(
          onPressed: () {
            if (k == 'C') {
              _clear();
            } else if (k == '⌫') {
              setState(() => _tendered = _tendered ~/ 10);
            } else {
              _append(int.parse(k));
            }
          },
          child: Text(k, style: const TextStyle(fontSize: 20)),
        );
      }).toList(),
    );
  }
}
