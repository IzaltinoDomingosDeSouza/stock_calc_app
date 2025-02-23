import 'package:flutter_test/flutter_test.dart';
import 'package:stock_calc_app/stock_calc.dart';
import "package:stock_calc_app/stock_info.dart";
import 'package:stock_calc_app/main.dart';

StockInfo stock = StockInfo(name: 'PETR4', price: 38.0, annualDividends: 7.91);

void main() {
  test('test StockCalc class investment', () {
    double amount = 38;

    var result = StockCalc.investment(stock, amount);

    expect(result['monthly_dividends'], closeTo(0.66, 0.01));
    expect(result['annually_dividends'], closeTo(7.91, 0.01));
  });

  test('test StockCalc class goal investment', () {
    double dividends = 7.91;
    expect(
      StockCalc.goal_investment(stock, dividends, true),
      closeTo(38, 0.01),
    );
  });
}
