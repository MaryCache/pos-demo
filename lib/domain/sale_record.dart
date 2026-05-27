import 'receipt.dart';

/// DB 保存済みの会計1件（id 付き）。
class SaleRecord {
  final int id;
  final Receipt receipt;
  const SaleRecord({required this.id, required this.receipt});
}
