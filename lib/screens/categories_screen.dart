import 'package:flutter/material.dart';
import '../patterns/app_theme_factory.dart';
import 'sub_product_screen.dart'; // Импортируем новый экран

class CategoriesScreen extends StatelessWidget {
  // УДАЛЕН 'const' для совместимости
  CategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final AppThemeFactory themeFactory = TechThemeFactory();

    final List<Map<String, dynamic>> categories = [
      {
        'name': 'Smartphones',
        'icon': Icons.phone_android,
        'color': Colors.greenAccent,
      },
      {'name': 'Laptops', 'icon': Icons.laptop_mac, 'color': Colors.blueAccent},
      {'name': 'Gadgets', 'icon': Icons.watch, 'color': Colors.redAccent},
      {
        'name': 'Accessories',
        'icon': Icons.headphones,
        'color': Colors.yellowAccent,
      },
    ];

    return Scaffold(
      backgroundColor: themeFactory.backgroundColor,
      appBar: AppBar(
        title: Text('Product Categories', style: themeFactory.titleStyle),
        backgroundColor: themeFactory.backgroundColor,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 16.0,
            mainAxisSpacing: 16.0,
            childAspectRatio: 1.0,
          ),
          itemCount: categories.length,
          itemBuilder: (context, index) {
            final category = categories[index];
            return _buildCategoryCard(context, category, themeFactory);
          },
        ),
      ),
    );
  }

  // Helper method: FIXES const error and implements navigation
  Widget _buildCategoryCard(
    BuildContext context,
    Map<String, dynamic> category,
    AppThemeFactory themeFactory,
  ) {
    // FIX: Using the constant value 127 instead of calling .round()
    const int alphaValue = 127;

    return InkWell(
      onTap: () {
        // IMPLEMENT NAVIGATION to SubProductScreen
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) =>
                SubProductScreen(categoryName: category['name'] as String),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey[850],
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: themeFactory.primaryColor.withAlpha(alphaValue),
          ),
        ),
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(
              category['icon'] as IconData,
              size: 48,
              color: category['color'] as Color,
            ),
            const SizedBox(height: 12),
            Text(
              category['name'] as String,
              style: themeFactory.textStyle.copyWith(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
