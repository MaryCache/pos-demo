import 'package:drift/drift.dart';
import 'tables.dart';

part 'database.g.dart';

@DriftDatabase(
  tables: [Products, Sales, SaleLines, SaleTaxGroups, DraftCartLines, DraftMeta],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase(super.e);

  @override
  int get schemaVersion => 1;
}
