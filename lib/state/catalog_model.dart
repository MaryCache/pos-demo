import 'dart:async';
import 'package:flutter/foundation.dart';
import '../data/product_repository.dart';
import '../domain/product.dart';

/// 商品一覧の購読と CRUD を仲介する。
class CatalogModel extends ChangeNotifier {
  final ProductRepository repo;
  List<Product> _products = [];
  StreamSubscription<List<Product>>? _sub;

  CatalogModel(this.repo) {
    // 商品一覧を購読し、DB 変更（追加・編集・削除）のたびに自動で再描画する。
    _sub = repo.watchAll().listen((list) {
      _products = list;
      notifyListeners();
    });
  }

  /// 現在の商品一覧（読み取り専用ビュー）。
  List<Product> get products => List.unmodifiable(_products);

  /// 商品をカテゴリ別にまとめた表示用マップ（出現順を保つ）。
  Map<String, List<Product>> get byCategory {
    final map = <String, List<Product>>{};
    for (final p in _products) {
      map.putIfAbsent(p.category, () => []).add(p);
    }
    return map;
  }

  /// 商品を追加する。watchAll 購読経由で一覧が更新される。
  Future<void> add(Product p) => repo.add(p);

  /// 商品を更新する。watchAll 購読経由で一覧が更新される。
  Future<void> edit(Product p) => repo.update(p);

  /// 商品を削除する。watchAll 購読経由で一覧が更新される。
  Future<void> remove(int id) => repo.delete(id);

  @override
  void dispose() {
    _sub?.cancel();
    super.dispose();
  }
}
