import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../data/sales_repository.dart';
import 'widgets/product_grid.dart' show yen;

/// セッション・累計の売上集計（DB から）。
class SalesSummaryView extends StatelessWidget {
  const SalesSummaryView({super.key});

  @override
  Widget build(BuildContext context) {
    final repo = context.read<SalesRepository>();
    return Scaffold(
      appBar: AppBar(title: const Text('売上集計')),
      body: StreamBuilder<SalesSummary>(
        stream: repo.watchSummary(),
        builder: (context, snap) {
          if (!snap.hasData) return const Center(child: CircularProgressIndicator());
          final s = snap.data!;
          final t = Theme.of(context).textTheme;
          return ListView(
            padding: const EdgeInsets.all(24),
            children: [
              Card(
                child: ListTile(
                  title: const Text('会計件数'),
                  trailing: Text('${s.count} 件', style: t.titleLarge),
                ),
              ),
              Card(
                child: ListTile(
                  title: const Text('売上合計（税込）'),
                  trailing: Text(yen(s.total), style: t.titleLarge),
                ),
              ),
              const SizedBox(height: 12),
              Text('税率別 税額', style: t.titleMedium),
              for (final entry in (s.taxByRate.entries.toList()
                    ..sort((a, b) => a.key.compareTo(b.key))))
                ListTile(
                  title: Text('${entry.key}%'),
                  trailing: Text(yen(entry.value)),
                ),
              if (s.taxByRate.isEmpty) const ListTile(title: Text('まだ売上がありません')),
            ],
          );
        },
      ),
    );
  }
}
