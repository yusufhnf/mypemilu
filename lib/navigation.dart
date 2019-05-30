import 'package:flutter/material.dart';
import 'package:mypemilu/home.dart';
import 'package:mypemilu/itemwilayah.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;

  final _layoutPage= [
    Home(),
    Wilayah()
  ];

  void _onTabItem(int index){
    setState(() {
      _selectedIndex = index;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _layoutPage.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.red[900],
        elevation: 3.0,
        unselectedItemColor: Colors.red,
        selectedItemColor: Colors.white,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.account_balance),
            title: Text('Nasional')
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.map),
            title: Text('Wilayah')
          ),
        ],
        type: BottomNavigationBarType.fixed,
        currentIndex: _selectedIndex,
        onTap: _onTabItem,
      ),
    );
  }
}