import 'package:final_project_application/screens/card_screen.dart';
import 'package:flutter/material.dart';
import 'categories_screen.dart';
import 'welcome_screen.dart';

class MainNavScreen extends StatefulWidget {
  const MainNavScreen({super.key});

  @override
  State<MainNavScreen> createState() => _MainNavScreenState();
}

class _MainNavScreenState extends State<MainNavScreen> {
  int _idx = 0;
  // Егер CategoriesScreen немесе CartScreen қызыл болса, оларды импорттау керек
  final pages = [const CategoriesScreen(), const CartScreen()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: currentTheme.backgroundColor,
      body: pages[_idx],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _idx,
        onTap: (i) => setState(() => _idx = i),
        selectedItemColor: currentTheme.primaryColor,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.category), label: "Shop"),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: "Cart",
          ),
        ],
      ),
    );
  }
}
