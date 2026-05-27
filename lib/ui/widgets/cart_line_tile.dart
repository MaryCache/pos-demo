import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../domain/cart_line.dart';
import '../../domain/discount.dart';
import '../../domain/register_calc.dart';
import '../../state/register_model.dart';
import 'product_grid.dart' show yen;

/// カート明細1行。数量増減・単品値引き・削除。
class CartLineTile extends StatelessWidget {
  final int index;
  final CartLine line;
  const CartLineTile({super.key, required this.index, required this.line});

  @override
  Widget build(BuildContext context) {
    final register = context.read<RegisterModel>();
    final lineExcl = line.product.unitPriceExclTax * line.quantity;
    final after = applyLineDiscount(lineExcl, line.lineDiscount);
    final hasDiscount = line.lineDiscount != null;

    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 8),
      title: Text('${line.product.name}  (${line.product.taxRate}%)'),
      subtitle: Row(
        children: [
          Text('${yen(line.product.unitPriceExclTax)} × ${line.quantity}'),
          if (hasDiscount) ...[
            const SizedBox(width: 8),
            Text('→ ${yen(after)}',
                style: TextStyle(color: Theme.of(context).colorScheme.error)),
          ],
        ],
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            icon: const Icon(Icons.remove_circle_outline),
            onPressed: () => register.changeQuantity(index, -1),
          ),
          Text('${line.quantity}'),
          IconButton(
            icon: const Icon(Icons.add_circle_outline),
            onPressed: () => register.changeQuantity(index, 1),
          ),
          IconButton(
            tooltip: '単品値引き',
            icon: Icon(Icons.percent,
                color: hasDiscount ? Theme.of(context).colorScheme.error : null),
            onPressed: () => _editDiscount(context, register),
          ),
          IconButton(
            icon: const Icon(Icons.delete_outline),
            onPressed: () => register.removeLine(index),
          ),
        ],
      ),
    );
  }

  Future<void> _editDiscount(BuildContext context, RegisterModel register) async {
    final result = await showDialog<Discount?>(
      context: context,
      builder: (_) => _DiscountDialog(initial: line.lineDiscount, title: '単品値引き'),
    );
    if (result == _DiscountDialog.cleared) {
      await register.setLineDiscount(index, null);
    } else if (result != null) {
      await register.setLineDiscount(index, result);
    }
  }
}

/// 値引き入力ダイアログ（単品・全体で共用）。
/// 戻り値: Discount=設定 / [cleared]=解除 / null=キャンセル。
class _DiscountDialog extends StatefulWidget {
  final Discount? initial;
  final String title;
  const _DiscountDialog({required this.initial, required this.title});

  static final Discount cleared = const Discount(DiscountType.amount, -1);

  @override
  State<_DiscountDialog> createState() => _DiscountDialogState();
}

class _DiscountDialogState extends State<_DiscountDialog> {
  late DiscountType _type = widget.initial?.type ?? DiscountType.amount;
  late final TextEditingController _ctrl =
      TextEditingController(text: widget.initial != null ? '${widget.initial!.value}' : '');

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.title),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SegmentedButton<DiscountType>(
            segments: const [
              ButtonSegment(value: DiscountType.amount, label: Text('円引き')),
              ButtonSegment(value: DiscountType.percent, label: Text('％引き')),
            ],
            selected: {_type},
            onSelectionChanged: (s) => setState(() => _type = s.first),
          ),
          const SizedBox(height: 12),
          TextField(
            controller: _ctrl,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              labelText: _type == DiscountType.amount ? '値引き額（円）' : '値引き率（％）',
            ),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context, _DiscountDialog.cleared),
          child: const Text('解除'),
        ),
        TextButton(
          onPressed: () => Navigator.pop(context, null),
          child: const Text('キャンセル'),
        ),
        FilledButton(
          onPressed: () {
            final v = int.tryParse(_ctrl.text) ?? 0;
            Navigator.pop(context, v <= 0 ? _DiscountDialog.cleared : Discount(_type, v));
          },
          child: const Text('適用'),
        ),
      ],
    );
  }
}

/// 全体値引きダイアログを開くヘルパ（cart_panel から使う）。
Future<void> editOrderDiscount(BuildContext context, RegisterModel register) async {
  final result = await showDialog<Discount?>(
    context: context,
    builder: (_) => _DiscountDialog(initial: register.orderDiscount, title: '全体値引き'),
  );
  if (result == _DiscountDialog.cleared) {
    await register.setOrderDiscount(null);
  } else if (result != null) {
    await register.setOrderDiscount(result);
  }
}
