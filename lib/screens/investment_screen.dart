import 'package:flutter/material.dart';
import 'package:stock_calc_app/models/stock_info.dart';
import 'package:stock_calc_app/models/stock_info_list.dart';
import 'package:stock_calc_app/utils/stock_calc.dart';

class InvestmentScreen extends StatefulWidget {
  @override
  InvestmentState createState() => InvestmentState();
}

class InvestmentState extends State<InvestmentScreen> {
  final StockInfoList stockInfoList = StockInfoList();
  TextEditingController _investmentAmount = TextEditingController();
  bool isInvestmentAmountValid = true;
  Map<String, double>? _dividends;
  StockInfo? _selectedStockInfo;

  @override
  void initState() {
    super.initState();
    _loadStockInfo();
  }

  @override
  void dispose() {
    _investmentAmount.dispose();
    super.dispose();
  }

  Future<void> _loadStockInfo() async {
    await stockInfoList.load();
    _selectedStockInfo = stockInfoList?.items?[0] ?? null;
    setState(() {});
  }

  bool validate_money_value(String? text) {
    if (text == null || text.isEmpty) return false;
    if (double.tryParse(text) == null) return false;
    return true;
  }

  void calcInvestmentAmount(String amount_text) {
    setState(() {
      isInvestmentAmountValid = validate_money_value(amount_text);
    });

    if (isInvestmentAmountValid != true) {
      _dividends = null;
      return;
    }
    if (_selectedStockInfo != null) {
      _dividends = StockCalc.investment(
        _selectedStockInfo!,
        double.tryParse(amount_text) ?? 0.00,
      );
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Investment calculated!'),
          backgroundColor: Colors.green,
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Selected stock is not valid!'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(centerTitle: true, title: Text('Investment')),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          DropdownButtonFormField<String>(
            value:
                _selectedStockInfo?.name.isNotEmpty == true
                    ? _selectedStockInfo?.name
                    : null,
            hint: const Text('Select stock', style: TextStyle(fontSize: 18)),
            items:
                stockInfoList?.items?.isNotEmpty == true
                    ? stockInfoList.items.map((StockInfo stockInfo) {
                      return DropdownMenuItem<String>(
                        value: stockInfo.name,
                        child: Text(
                          stockInfo.name,
                          style: const TextStyle(fontSize: 18),
                        ),
                      );
                    }).toList()
                    : [],
            onChanged: (String? stockName) {
              setState(() {
                _selectedStockInfo = stockInfoList.findByStockName(
                  stockName ?? "",
                );
              });
            },
            isExpanded: true,
          ),

          SizedBox(height: 25),
          TextField(
            controller: _investmentAmount,
            onSubmitted: (amount) => calcInvestmentAmount(amount),
            decoration: InputDecoration(
              prefixIcon: Icon(Icons.payments),
              hintText: 'Enter Investment Amount',
              border: OutlineInputBorder(),
              errorText:
                  isInvestmentAmountValid ? null : 'Please enter a valid value',
            ),
          ),
          SizedBox(height: 20),
          Text(
            "Estimated Dividends",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.green,
            ),
          ),
          SizedBox(height: 15),
          Text(
            "${_dividends?['monthly_dividends']?.toStringAsFixed(2) ?? '0.00'} monthly",
            style: TextStyle(fontSize: 18, color: Colors.black),
          ),
          Text(
            "${_dividends?['annually_dividends']?.toStringAsFixed(2) ?? '0.00'} annually",
            style: TextStyle(fontSize: 18, color: Colors.black),
          ),
        ],
      ),
    );
  }
}
