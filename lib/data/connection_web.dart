import 'package:drift/drift.dart';
import 'package:drift/wasm.dart';

/// ブラウザ内の永続ストレージ（IndexedDB/OPFS）に保存される drift コネクションを開く。
/// web/ に配置した sqlite3.wasm と drift_worker.js を参照する。
Future<QueryExecutor> openWebExecutor() async {
  final result = await WasmDatabase.open(
    databaseName: 'pos_demo',
    sqlite3Uri: Uri.parse('sqlite3.wasm'),
    // GitHub の pre-compiled release asset は drift_worker.js として配布される
    driftWorkerUri: Uri.parse('drift_worker.js'),
  );
  return result.resolvedExecutor;
}
