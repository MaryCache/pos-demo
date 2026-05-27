import 'package:flutter/foundation.dart';
import '../data/cart_repository.dart';
import '../data/sales_repository.dart';
import '../domain/cart_line.dart';
import '../domain/discount.dart';
import '../domain/product.dart';
import '../domain/receipt.dart';
import '../domain/register_calc.dart';

/// レジのカート状態と会計確定を扱う。計算は register_calc、永続化は Repository に委譲。
class RegisterModel extends ChangeNotifier {
  final CartRepository cartRepo;
  final SalesRepository salesRepo;

  List<CartLine> _lines = [];
  Discount? _orderDiscount;

  RegisterModel(this.cartRepo, this.salesRepo);

  /// 現在のカート明細（変更不可ビュー）。
  /// 変更は必ずモデルのメソッド経由にすること。永続化と notifyListeners を一体に保つため。
  List<CartLine> get lines => List.unmodifiable(_lines);

  /// 現在の全体値引き（未設定なら null）。
  Discount? get orderDiscount => _orderDiscount;

  /// 起動時に退避カートを復元する。
  Future<void> init() async {
    final (lines, discount) = await cartRepo.loadDraft();
    _lines = lines;
    _orderDiscount = discount;
    notifyListeners();
  }

  /// 現在のカートから会計結果を計算する（tendered 既定0＝合計プレビュー）。
  Receipt receiptFor(int tendered) =>
      computeReceipt(lines: _lines, orderDiscount: _orderDiscount, tendered: tendered);

  Future<void> _persistLines() => cartRepo.replaceLines(_lines);

  /// 商品をカートに追加する。同一商品が既にあれば新規行を増やさず数量を+1する。
  Future<void> addProduct(Product p) async {
    final idx = _lines.indexWhere((l) => l.product.id == p.id);
    if (idx >= 0) {
      _lines[idx] = _lines[idx].copyWith(quantity: _lines[idx].quantity + 1);
    } else {
      _lines.add(CartLine(product: p, quantity: 1));
    }
    await _persistLines();
    notifyListeners();
  }

  /// 指定明細の数量を [delta] だけ増減する。0以下になった明細は除去する。
  Future<void> changeQuantity(int index, int delta) async {
    final next = _lines[index].quantity + delta;
    if (next <= 0) {
      _lines.removeAt(index);
    } else {
      _lines[index] = _lines[index].copyWith(quantity: next);
    }
    await _persistLines();
    notifyListeners();
  }

  /// 指定明細をカートから削除する。
  Future<void> removeLine(int index) async {
    _lines.removeAt(index);
    await _persistLines();
    notifyListeners();
  }

  /// 指定明細の単品値引きを設定する（null で解除）。
  Future<void> setLineDiscount(int index, Discount? d) async {
    _lines[index] = _lines[index].copyWith(lineDiscount: d);
    await _persistLines();
    notifyListeners();
  }

  /// 全体値引きを設定する（null で解除）。
  Future<void> setOrderDiscount(Discount? d) async {
    _orderDiscount = d;
    await cartRepo.setOrderDiscount(d);
    notifyListeners();
  }

  /// 会計確定。Receipt を保存しカートをクリアして、確定 Receipt を返す。
  Future<Receipt> checkout(int tendered) async {
    final receipt =
        computeReceipt(lines: _lines, orderDiscount: _orderDiscount, tendered: tendered);
    await salesRepo.save(receipt);
    await cartRepo.clear();
    _lines = [];
    _orderDiscount = null;
    notifyListeners();
    return receipt;
  }
}
