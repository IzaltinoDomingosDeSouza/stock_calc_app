import 'dart:convert';

class StockInfo {
  String name;
  double price;
  double annualDividends;

  StockInfo({
    required this.name,
    required this.price,
    required this.annualDividends,
  });

  String toJson() {
    return json.encode({
      'name': name,
      'price': price,
      'annualDividends': annualDividends,
    });
  }

  factory StockInfo.fromJson(String jsonString) {
    final Map<String, dynamic> data = json.decode(jsonString);
    return StockInfo(
      name: data['name'],
      price: data['price'],
      annualDividends: data['annualDividends'],
    );
  }
}
