import 'package:flutter_test/flutter_test.dart';
import 'package:pos_demo/domain/discount.dart';
import 'package:pos_demo/domain/register_calc.dart';

void main() {
  group('applyLineDiscount', () {
    test('値引きなしはそのまま', () {
      expect(applyLineDiscount(1000, null), 1000);
    });
    test('金額値引きは減算', () {
      expect(applyLineDiscount(1000, const Discount(DiscountType.amount, 300)), 700);
    });
    test('金額値引きは下限0', () {
      expect(applyLineDiscount(1000, const Discount(DiscountType.amount, 1500)), 0);
    });
    test('率値引きは切り捨て', () {
      // 1000 * 33% = 330 → 1000-330 = 670
      expect(applyLineDiscount(1000, const Discount(DiscountType.percent, 33)), 670);
      // 999 * 10% = 99.9 → floor 99 → 999-99 = 900
      expect(applyLineDiscount(999, const Discount(DiscountType.percent, 10)), 900);
    });
  });
}
