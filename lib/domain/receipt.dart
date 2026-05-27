import 'discount.dart';

/// 税率グループ（8%/10%）ごとの集計。
class TaxGroupSummary {
  final int rate;

  /// 全体値引き按分後の課税ベース（税抜合計）。
  final int taxableExclTax;

  /// このグループの税額（1円未満切り捨て後）。
  final int tax;
  const TaxGroupSummary({required this.rate, required this.taxableExclTax, required this.tax});
}

/// レシート上の1明細（計算結果のスナップショット）。
class ReceiptLine {
  final String productName;
  final int unitPriceExclTax;
  final int taxRate;
  final int quantity;
  final Discount? lineDiscount;

  /// 単品値引き適用後の税抜額（数量分を含む小計）。
  final int lineExclAfter;
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

  /// 税率グループ別の集計（rate 昇順）。
  final List<TaxGroupSummary> groups;

  /// 値引き総額（単品値引き＋全体値引き）。
  final int discountTotal;

  /// 税込合計（各グループの課税ベース＋税額の総和）。
  final int grandTotal;

  /// 預かり金。
  final int tendered;

  /// お釣り（tendered - grandTotal。不足時は負値）。
  final int change;
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
