import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import '../models/db_models.dart'; // модели Hive
import '../patterns/app_theme_factory.dart'; // темы
import 'welcome_screen.dart'; // currentTheme
import 'sub_product_screen.dart'; // переход в подкатегорию

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final bool isTech = currentTheme is TechThemeFactory;
    final bool isCozy = currentTheme is CozyThemeFactory;

    final Box<Product> productBox = Hive.box<Product>('products');

    // ----------- НОРМАЛИЗАЦИЯ КАТЕГОРИЙ -----------
    final List<String> categories =
        productBox.values
            .cast<Product>()
            .map(
              (p) => p.category.trim().toLowerCase(),
            ) // FIX №1 — нормализация
            .where((c) => c.isNotEmpty) // FIX №2 — без пустых
            .toSet()
            .toList()
          ..sort();

    print("CATEGORIES FROM DB => $categories"); // для проверки

    return Scaffold(
      backgroundColor: currentTheme.backgroundColor,
      appBar: AppBar(
        title: Text(
          "Categories",
          style: currentTheme.titleStyle.copyWith(fontSize: 26),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
      ),

      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18),
        child: GridView.builder(
          physics: const BouncingScrollPhysics(),
          itemCount: categories.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 22,
            crossAxisSpacing: 22,
            childAspectRatio: 0.85,
          ),
          itemBuilder: (context, index) {
            final String categoryName = categories[index];
            final IconData icon = _categoryIcon(categoryName);

            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => SubProductScreen(category: categoryName),
                  ),
                );
              },
              child: Stack(
                children: [
                  // ---------- BACKGROUND CARD ----------
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(24),

                      // Cozy — мягкий градиент
                      gradient: isCozy
                          ? LinearGradient(
                              colors: [
                                currentTheme.primaryColor.withOpacity(0.25),
                                currentTheme.primaryColor.withOpacity(0.10),
                              ],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            )
                          : null,

                      // Tech — стеклянная карточка
                      color: isTech
                          ? Colors.white.withOpacity(
                              0.40,
                            ) // FIX: карточки не пропадают
                          : null,

                      border: Border.all(
                        color: currentTheme.primaryColor.withOpacity(
                          isTech ? 0.45 : 0.25, // FIX: четкая обводка
                        ),
                        width: isTech ? 1.6 : 1,
                      ),

                      boxShadow: [
                        if (isCozy)
                          BoxShadow(
                            color: currentTheme.primaryColor.withOpacity(0.35),
                            blurRadius: 18,
                            offset: const Offset(0, 8),
                          ),
                        if (isTech)
                          BoxShadow(
                            color: currentTheme.primaryColor.withOpacity(0.20),
                            blurRadius: 22,
                            offset: const Offset(0, 12),
                          ),
                      ],
                    ),
                  ),

                  // ---------- LARGE DECOR ICON ----------
                  Positioned(
                    top: -10,
                    right: -10,
                    child: Icon(
                      icon,
                      size: 92,
                      color: currentTheme.primaryColor.withOpacity(0.12),
                    ),
                  ),

                  // ---------- CONTENT ----------
                  Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // icon circle
                        Container(
                          padding: const EdgeInsets.all(18),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: isTech
                                ? Colors.white.withOpacity(0.15)
                                : Colors.white.withOpacity(0.80),
                            border: Border.all(
                              color: currentTheme.primaryColor.withOpacity(
                                0.40,
                              ),
                              width: isTech ? 1.2 : 1,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: currentTheme.primaryColor.withOpacity(
                                  isTech ? 0.18 : 0.25,
                                ),
                                blurRadius: isTech ? 14 : 10,
                                offset: const Offset(0, 6),
                              ),
                            ],
                          ),
                          child: Icon(
                            icon,
                            size: 38,
                            color: currentTheme.primaryColor,
                          ),
                        ),

                        const SizedBox(height: 14),

                        Text(
                          categoryName[0].toUpperCase() +
                              categoryName.substring(1),
                          style: currentTheme.titleStyle.copyWith(
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  // ------------ CATEGORY ICONS -------------
  IconData _categoryIcon(String category) {
    switch (category.toLowerCase()) {
      case "food":
        return Icons.fastfood;
      case "gadget":
      case "gadgets":
        return Icons.devices_other;
      case "home":
        return Icons.home_filled;
      case "clothes":
        return Icons.checkroom;
      default:
        return Icons.category;
    }
  }
}
