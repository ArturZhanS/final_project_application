import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';

import 'models/db_models.dart';
import 'services/cart_service.dart';
import 'screens/welcome_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();

  Hive.registerAdapter(ProductAdapter());
  Hive.registerAdapter(CardAdapter());

  await Hive.openBox<Product>('products');
  await Hive.openBox<PaymentCard>('cards');

  // ОЧИСТКА базы (делаем 1 раз чтобы пути обновились)
  await Hive.box<Product>('products').clear();

  // Загрузка товаров с фото
  await _seedData();

  runApp(
    ChangeNotifierProvider(create: (_) => CartService(), child: const MyApp()),
  );
}

// ------------------------------------------------------
//   ТОВАРЫ С ФОТОГРАФИЯМИ
// ------------------------------------------------------
Future<void> _seedData() async {
  final box = Hive.box<Product>('products');

  final products = [
    // FOOD
    Product(
      id: "food1",
      name: "Burger",
      price: 5.0,
      category: "food",
      imagePath: "assets/products/Food/food1.png",
    ),
    Product(
      id: "food2",
      name: "Pizza",
      price: 8.0,
      category: "food",
      imagePath: "assets/products/Food/food2.png",
    ),
    Product(
      id: "food3",
      name: "Fries",
      price: 3.0,
      category: "food",
      imagePath: "assets/products/Food/food3.png",
    ),
    Product(
      id: "food4",
      name: "Donut",
      price: 2.5,
      category: "food",
      imagePath: "assets/products/Food/food4.png",
    ),
    Product(
      id: "food5",
      name: "Hotdog",
      price: 4.0,
      category: "food",
      imagePath: "assets/products/Food/food5.png",
    ),
    Product(
      id: "food6",
      name: "Sandwich",
      price: 6.0,
      category: "food",
      imagePath: "assets/products/Food/food6.png",
    ),

    // GADGET
    Product(
      id: "gad1",
      name: "MacBook",
      price: 2000.0,
      category: "gadget",
      imagePath: "assets/products/Gadget/gadget1.png",
    ),
    Product(
      id: "gad2",
      name: "iPhone",
      price: 1200.0,
      category: "gadget",
      imagePath: "assets/products/Gadget/gadget2.png",
    ),
    Product(
      id: "gad3",
      name: "AirPods",
      price: 200.0,
      category: "gadget",
      imagePath: "assets/products/Gadget/gadget3.png",
    ),
    Product(
      id: "gad4",
      name: "Watch",
      price: 350.0,
      category: "gadget",
      imagePath: "assets/products/Gadget/gadget4.png",
    ),
    Product(
      id: "gad5",
      name: "Headphones",
      price: 150.0,
      category: "gadget",
      imagePath: "assets/products/Gadget/gadget5.png",
    ),
    Product(
      id: "gad6",
      name: "iPad",
      price: 900.0,
      category: "gadget",
      imagePath: "assets/products/Gadget/gadget6.png",
    ),

    // CLOTHES
    Product(
      id: "cl1",
      name: "Jeans",
      price: 40.0,
      category: "clothes",
      imagePath: "assets/products/Clothes/clothes1.png",
    ),
    Product(
      id: "cl2",
      name: "T-Shirt",
      price: 20.0,
      category: "clothes",
      imagePath: "assets/products/Clothes/clothes2.png",
    ),
    Product(
      id: "cl3",
      name: "Hoodie",
      price: 50.0,
      category: "clothes",
      imagePath: "assets/products/Clothes/clothes3.png",
    ),
    Product(
      id: "cl4",
      name: "Jacket",
      price: 80.0,
      category: "clothes",
      imagePath: "assets/products/Clothes/clothes4.png",
    ),
    Product(
      id: "cl5",
      name: "Sneakers",
      price: 100.0,
      category: "clothes",
      imagePath: "assets/products/Clothes/clothes5.png",
    ),
    Product(
      id: "cl6",
      name: "Cap",
      price: 15.0,
      category: "clothes",
      imagePath: "assets/products/Clothes/clothes6.png",
    ),

    // HOME
    Product(
      id: "h1",
      name: "Sofa",
      price: 300.0,
      category: "home",
      imagePath: "assets/products/Home/home1.png",
    ),
    Product(
      id: "h2",
      name: "Chair",
      price: 60.0,
      category: "home",
      imagePath: "assets/products/Home/home2.png",
    ),
    Product(
      id: "h3",
      name: "Table",
      price: 120.0,
      category: "home",
      imagePath: "assets/products/Home/home3.png",
    ),
    Product(
      id: "h4",
      name: "Lamp",
      price: 40.0,
      category: "home",
      imagePath: "assets/products/Home/home4.png",
    ),
    Product(
      id: "h5",
      name: "Carpet",
      price: 90.0,
      category: "home",
      imagePath: "assets/products/Home/home5.png",
    ),
    Product(
      id: "h6",
      name: "Cabinet",
      price: 150.0,
      category: "home",
      imagePath: "assets/products/Home/home6.png",
    ),
  ];

  for (final p in products) {
    box.add(p);
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const WelcomeScreen(),
    );
  }
}
