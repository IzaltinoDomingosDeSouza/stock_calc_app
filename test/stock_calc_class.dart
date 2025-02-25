import 'package:flutter_test/flutter_test.dart';
import 'package:stock_calc_app/utils/stock_calc.dart';
import "package:stock_calc_app/models/stock_info.dart";
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
    TimePeriod timePeriod = TimePeriod.Annually;
    double dividends = 1000;
    expect(
      StockCalc.goal_investment(stock, dividends, timePeriod),
      closeTo(4788, 0.01),
    );
  });
  
  test('test StockCalc class goal investment', () {
    TimePeriod timePeriod = TimePeriod.Monthly;
    double dividends = 1000;
    expect(
      StockCalc.goal_investment(stock, dividends, timePeriod),
      closeTo(57646, 0.01),
    );
  });
}
