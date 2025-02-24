import 'package:flutter/material.dart';
import 'package:stock_calc_app/stock_calc_navigation.dart';

void main() {
  runApp(const StockCalcApp());
}

class StockCalcApp extends StatelessWidget {
  const StockCalcApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Stock Calc',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: StockCalcNavigation(),
    );
  }
}
