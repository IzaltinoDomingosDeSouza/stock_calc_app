import 'package:flutter/material.dart';

class AddStockInfoScreen extends StatefulWidget {
  @override
  AddStockInfoState createState() => AddStockInfoState();
}

class AddStockInfoState extends State<AddStockInfoScreen> {
  TextEditingController _stockName = TextEditingController();
  TextEditingController _stockPrice = TextEditingController();
  TextEditingController _stockAnnualDividends = TextEditingController();

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

  void saveStockInfo() {
    setState(() {
      _isStockNameValid = validate_text(_stockName.text);
      _isStockPriceValid = validate_money_value(_stockPrice.text);
      _isStockAnnualDividendsValid = validate_money_value(
        _stockAnnualDividends.text,
      );
    });
    // TODO save this data
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(centerTitle: true, title: Text('Add Stock Info')),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextField(
            controller: _stockName,
            decoration: InputDecoration(
              prefixIcon: Icon(Icons.label),
              hintText: 'Enter Stock Name',
              border: OutlineInputBorder(),
              errorText: _isStockNameValid ? null : 'Please enter a name',
            ),
          ),
          SizedBox(height: 20),
          TextField(
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
          SizedBox(height: 20),
          TextField(
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
          SizedBox(height: 30),
          ElevatedButton(
            onPressed: saveStockInfo,
            child: Icon(Icons.add, size: 24),
          ),
        ],
      ),
    );
  }
}
