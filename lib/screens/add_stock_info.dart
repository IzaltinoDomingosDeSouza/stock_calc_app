import 'package:flutter/material.dart';
import 'package:stock_calc_app/models/stock_info.dart';
import 'package:stock_calc_app/models/stock_info_list.dart';

class AddStockInfoScreen extends StatefulWidget {
  @override
  AddStockInfoState createState() => AddStockInfoState();
}

class AddStockInfoState extends State<AddStockInfoScreen> {
  final StockInfoList stockInfoList = StockInfoList();

  TextEditingController _stockName = TextEditingController();
  TextEditingController _stockPrice = TextEditingController();
  TextEditingController _stockAnnualDividends = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadStockInfo();
  }

  @override
  void dispose() {
    _stockName.dispose();
    _stockPrice.dispose();
    _stockAnnualDividends.dispose();
    super.dispose();
  }

  Future<void> _loadStockInfo() async {
    await stockInfoList.load();
    setState(() {});
  }

  bool _isStockNameValid = true;
  bool _isStockPriceValid = true;
  bool _isStockAnnualDividendsValid = true;

  bool validate_text(String? text) {
    return text?.isNotEmpty ?? false;
  }

  bool validate_money_value(String? text) {
    if (text == null || text.isEmpty) return false;
    if (double.tryParse(text) == null) return false;
    return true;
  }

  Future<void> loadStockInfoByName(String stockName) async {
    StockInfo? stockInfo = stockInfoList.findByStockName(stockName);
    if (stockInfo != null) {
      setState(() {
        _stockName.text = _stockName.text.toUpperCase();
        _stockPrice.text = stockInfo.price.toStringAsFixed(2);
        _stockAnnualDividends.text = stockInfo.annualDividends.toStringAsFixed(
          2,
        );
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Stock info $stockName loaded successfully!"),
          backgroundColor: Colors.green,
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Stock info $stockName may not exist!"),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  Future<void> saveStockInfo() async {
    setState(() {
      _stockName.text = _stockName.text.toUpperCase();
      _isStockNameValid = validate_text(_stockName.text);
      _isStockPriceValid = validate_money_value(_stockPrice.text);
      _isStockAnnualDividendsValid = validate_money_value(
        _stockAnnualDividends.text,
      );
    });

    if (_isStockNameValid &&
        _isStockPriceValid &&
        _isStockAnnualDividendsValid) {
      bool wasSaved = await stockInfoList.addOrUpdate(
        StockInfo(
          name: _stockName.text,
          price: double.parse(_stockPrice.text),
          annualDividends: double.parse(_stockAnnualDividends.text),
        ),
      );

      if (wasSaved) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Stock info saved successfully!"),
            backgroundColor: Colors.green,
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text('Failed to save stock info.'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      children: [
        Flexible(
          child: TextField(
            controller: _stockName,
            onSubmitted: (stockName) => loadStockInfoByName(stockName.toUpperCase()),
            decoration: InputDecoration(
              prefixIcon: Icon(Icons.label),
              hintText: 'Enter Stock Name',
              border: OutlineInputBorder(),
              errorText: _isStockNameValid ? null : 'Please enter a name',
            ),
          ),
        ),
        Flexible(
          child: TextField(
            controller: _stockPrice,
            decoration: InputDecoration(
              prefixIcon: Icon(Icons.payments),
              hintText: 'Enter Stock Price',
              border: OutlineInputBorder(),
              errorText:
                  _isStockPriceValid
                      ? null
                      : 'Please enter a valid value number',
            ),
          ),
        ),
        Flexible(
          child: TextField(
            controller: _stockAnnualDividends,
            decoration: InputDecoration(
              prefixIcon: Icon(Icons.savings),
              hintText: 'Enter Annual Dividends',
              border: OutlineInputBorder(),
              errorText:
                  _isStockAnnualDividendsValid
                      ? null
                      : 'Please enter a valid value number',
            ),
          ),
        ),
        ElevatedButton(
          onPressed: saveStockInfo,
          child: Icon(Icons.add, size: 24),
        ),
      ],
    );
  }
}
