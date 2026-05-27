import 'package:flutter_test/flutter_test.dart';
import 'package:pos_demo/domain/discount.dart';
import 'package:pos_demo/domain/register_calc.dart';
import 'package:pos_demo/domain/product.dart';
import 'package:pos_demo/domain/cart_line.dart';

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

  group('computeReceipt', () {
    Product food(int price) => Product(id: 1, name: '弁当', unitPriceExclTax: price, taxRate: 8, category: '食品');
    Product goods(int price) => Product(id: 2, name: '洗剤', unitPriceExclTax: price, taxRate: 10, category: '日用品');

    test('空カートは合計0', () {
      final r = computeReceipt(lines: const [], orderDiscount: null, tendered: 0);
      expect(r.grandTotal, 0);
      expect(r.groups, isEmpty);
      expect(r.change, 0);
    });

    test('税率混在の集計（8%と10%）', () {
      final r = computeReceipt(
        lines: [
          CartLine(product: food(500), quantity: 2),  // 8% 税抜1000
          CartLine(product: goods(300), quantity: 1), // 10% 税抜300
        ],
        orderDiscount: null,
        tendered: 2000,
      );
      // 8%: 税抜1000 税80 / 10%: 税抜300 税30
      final g8 = r.groups.firstWhere((g) => g.rate == 8);
      final g10 = r.groups.firstWhere((g) => g.rate == 10);
      expect(g8.taxableExclTax, 1000);
      expect(g8.tax, 80);
      expect(g10.taxableExclTax, 300);
      expect(g10.tax, 30);
      expect(r.grandTotal, 1000 + 80 + 300 + 30); // 1410
      expect(r.change, 2000 - 1410); // 590
      expect(r.groups.map((g) => g.rate).toList(), [8, 10]); // rate 昇順
    });

    test('単品値引き＋全体値引き（按分）', () {
      final r = computeReceipt(
        lines: [
          CartLine(product: food(1000), quantity: 1, lineDiscount: const Discount(DiscountType.amount, 200)), // 8% → 800
          CartLine(product: goods(1000), quantity: 1), // 10% → 1000
        ],
        orderDiscount: const Discount(DiscountType.amount, 180), // 全体180円
        tendered: 2000,
      );
      // 単品後小計 8%:800 / 10%:1000, total=1800
      // 全体180按分: 8%:180*800/1800=80, 10%:180*1000/1800=100 端数0
      // 課税ベース 8%:720 / 10%:900
      // 税 8%:floor(720*0.08)=57, 10%:90
      final g8 = r.groups.firstWhere((g) => g.rate == 8);
      final g10 = r.groups.firstWhere((g) => g.rate == 10);
      expect(g8.taxableExclTax, 720);
      expect(g8.tax, 57);
      expect(g10.taxableExclTax, 900);
      expect(g10.tax, 90);
      expect(r.grandTotal, 720 + 57 + 900 + 90); // 1767
      expect(r.discountTotal, 200 + 180); // 単品200 + 全体180 = 380
    });

    test('お釣り不足はマイナス', () {
      final r = computeReceipt(
        lines: [CartLine(product: goods(1000), quantity: 1)],
        orderDiscount: null,
        tendered: 500,
      );
      expect(r.change, 500 - 1100); // -600
    });
  });
}
