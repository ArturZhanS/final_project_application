import 'package:flutter/material.dart';
import '../patterns/app_theme_factory.dart';

import 'categories_screen.dart';
import 'card_screen.dart';
import 'welcome_screen.dart';

class MainNavScreen extends StatefulWidget {
  const MainNavScreen({super.key});

  @override
  State<MainNavScreen> createState() => _MainNavScreenState();
}

class _MainNavScreenState extends State<MainNavScreen> {
  final AppThemeFactory themeFactory = TechThemeFactory();

  int _selectedIndex = 0;

  late final List<Widget> _screens = [
    CategoriesScreen(),

    CardScreen(),

    WelcomeScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens.elementAt(_selectedIndex),

      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: themeFactory.backgroundColor,
        selectedItemColor: themeFactory.primaryColor,
        unselectedItemColor: Colors.grey,

        currentIndex: _selectedIndex,

        onTap: _onItemTapped,

        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.category),
            label: 'Categories',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: 'Cart',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }
}
