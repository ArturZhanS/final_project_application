import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'models/db_models.dart';
import 'services/cart_service.dart';
import 'screens/welcome_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();

  Hive.registerAdapter(ProductAdapter());
  Hive.registerAdapter(CardAdapter());

  await Hive.openBox<Product>('products');
  await Hive.openBox<PaymentCard>('cards');

  _seedData();

  runApp(
    ChangeNotifierProvider(create: (_) => CartService(), child: const MyApp()),
  );
}

void _seedData() {
  final box = Hive.box<Product>('products');
  if (box.isEmpty) {
    box.add(
      Product(
        id: '1',
        name: 'Burger',
        price: 5.0,
        category: 'food',
        imagePath: '',
      ),
    );
    box.add(
      Product(
        id: '2',
        name: 'MacBook',
        price: 2000.0,
        category: 'gadget',
        imagePath: '',
      ),
    );
    box.add(
      Product(
        id: '3',
        name: 'Jeans',
        price: 40.0,
        category: 'clothes',
        imagePath: '',
      ),
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Final E-commerce Project',
      home: const WelcomeScreen(),
    );
  }
}
