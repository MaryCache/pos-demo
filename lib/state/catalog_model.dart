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
    _sub = repo.watchAll().listen((list) {
      _products = list;
      notifyListeners();
    });
  }

  List<Product> get products => List.unmodifiable(_products);

  /// 商品をカテゴリ別にまとめた表示用マップ（出現順を保つ）。
  Map<String, List<Product>> get byCategory {
    final map = <String, List<Product>>{};
    for (final p in _products) {
      map.putIfAbsent(p.category, () => []).add(p);
    }
    return map;
  }

  Future<void> add(Product p) => repo.add(p);
  Future<void> edit(Product p) => repo.update(p);
  Future<void> remove(int id) => repo.delete(id);

  @override
  void dispose() {
    _sub?.cancel();
    super.dispose();
  }
}
