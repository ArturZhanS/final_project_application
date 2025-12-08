import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import '../models/db_models.dart';
import '../services/cart_service.dart';
import 'welcome_screen.dart';

class SubProductScreen extends StatelessWidget {
  final String category;

  const SubProductScreen({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    final box = Hive.box<Product>('products');
    final categoryProducts = box.values
        .where((p) => p.category == category)
        .toList();

    return Scaffold(
      backgroundColor: currentTheme.backgroundColor,
      appBar: AppBar(
        title: Text(
          category.toUpperCase(),
          style: const TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: categoryProducts.isEmpty
          ? const Center(child: Text("No products"))
          : GridView.builder(
              padding: const EdgeInsets.all(10),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.75,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              itemCount: categoryProducts.length,
              itemBuilder: (ctx, i) {
                final p = categoryProducts[i];
                return currentTheme.createProductCard(
                  name: p.name,
                  price: "\$${p.price}",
                  image: const Icon(
                    Icons.shopping_bag,
                    size: 40,
                    color: Colors.grey,
                  ),
                  onAdd: () {
                    Provider.of<CartService>(
                      context,
                      listen: false,
                    ).addToCart(p);
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Added!"),
                        duration: Duration(milliseconds: 300),
                      ),
                    );
                  },
                );
              },
            ),
    );
  }
}
