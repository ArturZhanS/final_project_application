import 'package:flutter/material.dart';
import '../patterns/app_theme_factory.dart';

class SubProductScreen extends StatelessWidget {
  // Экран принимает имя категории, чтобы отобразить его в заголовке
  final String categoryName;

  // УДАЛИТЕ const ИЗ КОНСТРУКТОРА (для совместимости с NavScreen)
  const SubProductScreen({super.key, required this.categoryName});

  @override
  Widget build(BuildContext context) {
    final AppThemeFactory themeFactory = TechThemeFactory();

    // Имитация списка реальных продуктов (для демонстрации)
    final List<Map<String, dynamic>> products = [
      {
        'name': 'Super Phone X',
        'price': '1299.00 USD',
        'image': Icons.mobile_friendly,
      },
      {
        'name': 'Ultra Laptop Z',
        'price': '1850.50 USD',
        'image': Icons.computer,
      },
      {'name': 'Smart Watch 9', 'price': '350.00 USD', 'image': Icons.watch},
      {
        'name': 'Wireless Headphones',
        'price': '150.99 USD',
        'image': Icons.headset_mic,
      },
    ];

    return Scaffold(
      backgroundColor: themeFactory.backgroundColor,
      appBar: AppBar(
        title: Text(categoryName, style: themeFactory.titleStyle),
        backgroundColor: themeFactory.backgroundColor,
        elevation: 0,
        // Кнопка "назад" для возврата к CategoriesScreen
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: themeFactory.primaryColor),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        // Используем GridView для отображения продуктов
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 8.0,
            mainAxisSpacing: 8.0,
            childAspectRatio: 0.75, // Карточки выше, чем шире
          ),
          itemCount: products.length,
          itemBuilder: (context, index) {
            final product = products[index];

            // Используем МЕТОД ФАБРИКИ для создания карточки продукта
            return themeFactory.createProductCard(
              name: product['name'] as String,
              price: product['price'] as String,
              image: Icon(
                product['image'] as IconData,
                size: 60,
                color: themeFactory.primaryColor.withAlpha(
                  (255 * 0.7).round(),
                ), // Мягкий основной цвет
              ),
              onAdd: () {
                // TODO: Реализовать логику добавления товара в корзину (Behavioral/Command Pattern)
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Added ${product['name']} to cart!')),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
