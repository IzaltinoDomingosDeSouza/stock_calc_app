import 'package:flutter/material.dart';
import 'package:stock_calc_app/screens/add_stock_info.dart';

class StockCalcNavigation extends StatefulWidget {
  @override
  _StockCalcNavigationState createState() => _StockCalcNavigationState();
}

class _StockCalcNavigationState extends State<StockCalcNavigation> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    Center(child: Text('Investment Screen')), //TODO
    Center(child: Text('Goal Investment Screen')), //TODO
    AddStockInfoScreen(),
  ];

  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: _onTabTapped,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.calculate),
            label: 'Investment',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.track_changes),
            label: 'Goal Investment',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add),
            label: 'Add Stock',
          ),
        ],
      ),
    );
  }
}
