import 'package:flutter/material.dart';
import 'package:casher/pages/wallet_page.dart';
import 'package:casher/pages/category_page.dart';
import 'package:casher/pages/profile_page.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return BottomNavBarScreenState();
  }
}

class BottomNavBarScreenState extends State<BottomNavBar> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  final List<Widget> _widgetOptions = <Widget>[
    const WalletPage(),
    const CategoryPage(),
    const ProfilePage()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        elevation: 0,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              icon: Icon(Icons.account_balance_wallet),
              label: 'Кошелёк',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.assessment),
            label: 'Категории',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_box),
            label: 'Аккаунт',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.deepPurpleAccent,
        unselectedItemColor: Colors.black,
        backgroundColor: Colors.white,
        onTap: _onItemTapped,
      ),
    );
  }
}