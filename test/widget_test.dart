import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:stock_calc_app/main.dart';

void main() {
  testWidgets('StockCalcApp has the correct title text', (WidgetTester tester) async {

    await tester.pumpWidget(const StockCalcApp());

    expect(find.text('Stock Calc App'), findsOneWidget);
    expect(find.text('Stock Calc'), findsNothing);
  });
}

