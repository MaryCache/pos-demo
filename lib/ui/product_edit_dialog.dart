import 'package:flutter/material.dart';
import '../domain/product.dart';

/// 商品の追加・編集フォーム。確定で Product を返す（id は editing 時のみ保持）。
Future<Product?> showProductEditDialog(BuildContext context, {Product? editing}) {
  return showDialog<Product>(
    context: context,
    builder: (_) => _ProductEditDialog(editing: editing),
  );
}

class _ProductEditDialog extends StatefulWidget {
  final Product? editing;
  const _ProductEditDialog({required this.editing});

  @override
  State<_ProductEditDialog> createState() => _ProductEditDialogState();
}

class _ProductEditDialogState extends State<_ProductEditDialog> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _name =
      TextEditingController(text: widget.editing?.name ?? '');
  late final TextEditingController _price =
      TextEditingController(text: widget.editing != null ? '${widget.editing!.unitPriceExclTax}' : '');
  late final TextEditingController _category =
      TextEditingController(text: widget.editing?.category ?? '');
  late int _taxRate = widget.editing?.taxRate ?? 8;

  @override
  void dispose() {
    _name.dispose();
    _price.dispose();
    _category.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.editing == null ? '商品を追加' : '商品を編集'),
      content: Form(
        key: _formKey,
        child: SizedBox(
          width: 360,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: _name,
                decoration: const InputDecoration(labelText: '商品名'),
                validator: (v) => (v == null || v.trim().isEmpty) ? '必須' : null,
              ),
              TextFormField(
                controller: _price,
                decoration: const InputDecoration(labelText: '税抜価格（円）'),
                keyboardType: TextInputType.number,
                validator: (v) {
                  final n = int.tryParse(v ?? '');
                  return (n == null || n < 0) ? '0以上の整数' : null;
                },
              ),
              TextFormField(
                controller: _category,
                decoration: const InputDecoration(labelText: 'カテゴリ'),
                validator: (v) => (v == null || v.trim().isEmpty) ? '必須' : null,
              ),
              const SizedBox(height: 12),
              SegmentedButton<int>(
                segments: const [
                  ButtonSegment(value: 8, label: Text('軽減 8%')),
                  ButtonSegment(value: 10, label: Text('標準 10%')),
                ],
                selected: {_taxRate},
                onSelectionChanged: (s) => setState(() => _taxRate = s.first),
              ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(onPressed: () => Navigator.pop(context), child: const Text('キャンセル')),
        FilledButton(
          onPressed: () {
            if (!_formKey.currentState!.validate()) return;
            Navigator.pop(
              context,
              Product(
                id: widget.editing?.id,
                name: _name.text.trim(),
                unitPriceExclTax: int.parse(_price.text),
                taxRate: _taxRate,
                category: _category.text.trim(),
              ),
            );
          },
          child: const Text('保存'),
        ),
      ],
    );
  }
}
