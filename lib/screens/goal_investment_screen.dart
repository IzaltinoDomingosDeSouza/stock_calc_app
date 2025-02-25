import 'package:flutter/material.dart';
import 'package:stock_calc_app/models/stock_info.dart';
import 'package:stock_calc_app/models/stock_info_list.dart';
import 'package:stock_calc_app/utils/stock_calc.dart';
import 'package:stock_calc_app/screens/utils/stock_dropdown_menu.dart';

class GoalInvestmentScreen extends StatefulWidget {
  @override
  GoalInvestmentState createState() => GoalInvestmentState();
}

class GoalInvestmentState extends State<GoalInvestmentScreen> {
  final StockInfoList stockInfoList = StockInfoList();
  TextEditingController _requiredAmount = TextEditingController();
  bool isRequiredAmountValid = true;
  StockInfo? _selectedStockInfo;
  TimePeriod selectedTimePeriod = TimePeriod.Annually;
  double? _requiredAmountResult;

  @override
  void initState() {
    super.initState();
    _loadStockInfo();
  }

  @override
  void dispose() {
    _requiredAmount.dispose();
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

  void calcRequiredAmount(String dividends_text) {
    setState(() {
      isRequiredAmountValid = validate_money_value(dividends_text);
    });

    if (isRequiredAmountValid != true) {
      _requiredAmountResult = null;
      return;
    }
    if (_selectedStockInfo != null) {
      _requiredAmountResult = StockCalc.goal_investment(
        _selectedStockInfo!,
        double.tryParse(dividends_text) ?? 0.00,
        selectedTimePeriod,
      );
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Required amount calculated!'),
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
      appBar: AppBar(centerTitle: true, title: Text('Goal Investment')),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            StockDropDownMenu(
              stocks: stockInfoList?.items ?? [],
              selectedStockName: _selectedStockInfo?.name ?? null,
              onSelectStock: (StockInfo? selected) {
                setState(() {
                  _selectedStockInfo = selected;
                });
              },
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: TextField(
                    controller: _requiredAmount,
                    onSubmitted: (amount) => calcRequiredAmount(amount),
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.savings),
                      hintText: 'Enter Dividends Amount',
                      border: OutlineInputBorder(),
                      errorText:
                          isRequiredAmountValid
                              ? null
                              : 'Please enter a valid value',
                    ),
                  ),
                ),
                SizedBox(width: 5),
                Container(
                  width: MediaQuery.of(context).size.width * 0.10,
                  child: DropdownMenu<String>(
                    initialSelection: selectedTimePeriod.name,
                    dropdownMenuEntries: const [
                      DropdownMenuEntry(value: 'Annually', label: 'Annually'),
                      DropdownMenuEntry(value: 'Monthly', label: 'Monthly'),
                    ],
                    onSelected: (String? timePeriod) {
                      if (timePeriod == null || timePeriod == 'Annually')
                        selectedTimePeriod = TimePeriod.Annually;
                      else
                        selectedTimePeriod = TimePeriod.Monthly;
                    },
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            Text(
              "Estimated Required Amount",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.green,
              ),
            ),
            SizedBox(height: 15),
            Text(
              "${_requiredAmountResult?.toStringAsFixed(2) ?? '0.00'}",
              style: TextStyle(fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }
}
