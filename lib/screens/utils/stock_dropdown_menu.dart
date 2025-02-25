import 'package:flutter/material.dart';
import 'package:stock_calc_app/models/stock_info.dart';

class StockDropDownMenu extends StatelessWidget {
  final List<StockInfo> stocks;
  final String? selectedStockName;
  final Function(StockInfo?) onSelectStock;

  StockDropDownMenu({
    super.key,
    required this.stocks,
    required this.selectedStockName,
    required this.onSelectStock,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      value: selectedStockName,
      hint: const Text('Select stock', style: TextStyle(fontSize: 18)),
      items:
          stocks.isNotEmpty
              ? stocks.map((StockInfo stock) {
                return DropdownMenuItem<String>(
                  value: stock.name,
                  child: Text(stock.name, style: const TextStyle(fontSize: 18)),
                );
              }).toList()
              : [],
      onChanged: (String? stockName) {
        if (stockName != null) {
          int index = stocks.indexWhere((stock) => stock.name == stockName);
          if (index != -1) onSelectStock(stocks[index]);
        }
      },
      isExpanded: true,
    );
  }
}
