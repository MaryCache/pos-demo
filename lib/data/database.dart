import 'package:drift/drift.dart';
import 'tables.dart';

part 'database.g.dart';

/// アプリ全体の drift データベース。全テーブルを束ねる単一エントリポイント。
@DriftDatabase(
  tables: [Products, Sales, SaleLines, SaleTaxGroups, DraftCartLines, DraftMeta],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase(super.e);

  @override
  int get schemaVersion => 1;
}
