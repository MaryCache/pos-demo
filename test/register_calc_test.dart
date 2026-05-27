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

  group('distributeOrderDiscount', () {
    test('値引き0は全グループ0', () {
      expect(distributeOrderDiscount({8: 1000, 10: 1000}, 0), {8: 0, 10: 0});
    });
    test('小計合計0は全グループ0', () {
      expect(distributeOrderDiscount({8: 0, 10: 0}, 100), {8: 0, 10: 0});
    });
    test('比例配分し端数は最大小計グループへ', () {
      // D=100, 小計 8%:300 / 10%:700, total=1000
      // 8%: 100*300/1000=30, 10%: 100*700/1000=70, 端数0
      expect(distributeOrderDiscount({8: 300, 10: 700}, 100), {8: 30, 10: 70});
    });
    test('端数が出るとき最大グループへ寄せ合計が一致', () {
      // D=10, 小計 8%:333 / 10%:667, total=1000
      // 8%: 10*333/1000=3 (3.33→3), 10%: 10*667/1000=6 (6.67→6) 計9 端数1→最大(10%)へ
      final r = distributeOrderDiscount({8: 333, 10: 667}, 10);
      expect(r, {8: 3, 10: 7});
      expect(r.values.reduce((a, b) => a + b), 10);
    });
  });
}
