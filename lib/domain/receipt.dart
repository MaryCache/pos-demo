import 'discount.dart';

/// 税率グループ（8%/10%）ごとの集計。
class TaxGroupSummary {
  final int rate;
  final int taxableExclTax; // 値引後の税抜合計
  final int tax;            // 1円未満切り捨て後の税額
  const TaxGroupSummary({required this.rate, required this.taxableExclTax, required this.tax});
}

/// レシート上の1明細（計算結果のスナップショット）。
class ReceiptLine {
  final String productName;
  final int unitPriceExclTax;
  final int taxRate;
  final int quantity;
  final Discount? lineDiscount;
  final int lineExclAfter; // 単品値引き適用後の税抜額
  const ReceiptLine({
    required this.productName,
    required this.unitPriceExclTax,
    required this.taxRate,
    required this.quantity,
    required this.lineDiscount,
    required this.lineExclAfter,
  });
}

/// 1会計分の計算結果。
class Receipt {
  final List<ReceiptLine> lines;
  final List<TaxGroupSummary> groups; // rate 昇順
  final int discountTotal;            // 値引き総額（単品＋全体）
  final int grandTotal;               // 税込合計
  final int tendered;                 // 預かり金
  final int change;                   // お釣り（tendered - grandTotal）
  final DateTime timestamp;
  const Receipt({
    required this.lines,
    required this.groups,
    required this.discountTotal,
    required this.grandTotal,
    required this.tendered,
    required this.change,
    required this.timestamp,
  });
}
