import 'package:drift/drift.dart';
import 'package:drift/wasm.dart';
import 'package:flutter/foundation.dart';

/// ブラウザ内の永続ストレージ（IndexedDB/OPFS）に保存される drift コネクションを開く。
/// web/ に配置した sqlite3.wasm と drift_worker.js を参照する。
Future<QueryExecutor> openWebExecutor() async {
  final result = await WasmDatabase.open(
    databaseName: 'pos_demo',
    sqlite3Uri: Uri.parse('sqlite3.wasm'),
    // GitHub の pre-compiled release asset は drift_worker.js として配布される
    driftWorkerUri: Uri.parse('drift_worker.js'),
  );
  // 永続化はデモの目玉機能。COOP/COEP 未設定時に OPFS でなく IndexedDB へ落ちる等の
  // 実装選択を可視化し、無音の永続化失敗を診断可能にする。
  debugPrint('drift web: chosen=${result.chosenImplementation}, missing=${result.missingFeatures}');
  if (result.missingFeatures.isNotEmpty) {
    debugPrint('drift web: ストレージが制限されています。永続化が期待どおりに機能しない可能性があります。');
  }
  return result.resolvedExecutor;
}
