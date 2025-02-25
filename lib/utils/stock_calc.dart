import "package:stock_calc_app/models/stock_info.dart";

class StockCalc {
  static Map<String, double> investment(StockInfo stock, double amount) {
    int share = (amount / stock.price).floor();

    double dividends = share * stock.annualDividends;
    return {
      'monthly_dividends': dividends / 12,
      'annually_dividends': dividends,
    };
  }

  static double goal_investment(
    StockInfo stock,
    double dividends,
    bool isAnnually,
  ) {
    int share = 0;
    if (isAnnually)
      share = (dividends / stock.annualDividends).floor();
    else
      share = (dividends / (stock.annualDividends / 12)).floor();

    return share * stock.price;
  }
}
