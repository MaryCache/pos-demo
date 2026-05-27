import 'discount.dart';
import 'product.dart';

/// カート上の1明細。
class CartLine {
  final Product product;
  final int quantity;
  final Discount? lineDiscount;

  const CartLine({required this.product, required this.quantity, this.lineDiscount});

  CartLine copyWith({Product? product, int? quantity, Object? lineDiscount = _sentinel}) {
    return CartLine(
      product: product ?? this.product,
      quantity: quantity ?? this.quantity,
      lineDiscount: lineDiscount == _sentinel ? this.lineDiscount : lineDiscount as Discount?,
    );
  }
}

/// copyWith で「null を明示的に渡して値引きを消す」と「未指定」を区別するための番兵。
const Object _sentinel = Object();
