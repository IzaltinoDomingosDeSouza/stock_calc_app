import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stock_calc_app/models/stock_info.dart';

class StockInfoList {
  List<StockInfo> _stockInfoList = [];

  static final StockInfoList _instance = StockInfoList._internal();
  StockInfoList._internal();

  factory StockInfoList() {
    return _instance;
  }
  Future<void> load() async {
    final _prefs = await SharedPreferences.getInstance();
    String? _stockInfoData = _prefs.getString('stock_info_data');

    if (_stockInfoData == null || _stockInfoData.isEmpty) {
      _stockInfoList = [];
      return;
    }

    _stockInfoList =
        (jsonDecode(_stockInfoData) as List)
            .map((item) => StockInfo.fromJson(item))
            .toList();
  }

  Future<bool> save() async {
    final _prefs = await SharedPreferences.getInstance();
    String stockListJson = jsonEncode(
      _stockInfoList.map((stock) => stock.toJson()).toList(),
    );
    return await _prefs.setString('stock_info_data', stockListJson);
  }

  Future<bool> addOrUpdate(StockInfo stock) async {
    int index = _stockInfoList.indexWhere((s) => s.name == stock.name);
    if (index != -1) {
      _stockInfoList[index] = stock;
    } else {
      _stockInfoList.add(stock);
    }
    return await save();
  }

  StockInfo? findByStockName(String stockName) {
    int index = _stockInfoList.indexWhere((stock) => stock.name == stockName);
    if (index != -1)
      return _stockInfoList[index];
    else
      return null;
  }
}
