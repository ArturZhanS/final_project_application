import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';

import 'models/db_models.dart';
import 'services/cart_service.dart';
import 'screens/welcome_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // --------- ИНИЦИАЛИЗАЦИЯ HIVE ----------
  await Hive.initFlutter();

  Hive.registerAdapter(ProductAdapter());
  Hive.registerAdapter(CardAdapter());

  await Hive.openBox<Product>('products');
  await Hive.openBox<PaymentCard>('cards');

  // --------- ДОБАВЛЯЕМ ДАННЫЕ / ЧИНИМ КАТЕГОРИИ ----------
  await _seedData();

  runApp(
    ChangeNotifierProvider(create: (_) => CartService(), child: const MyApp()),
  );
}

// ----------------------------------------------------------
//   SEED DATA — фиксируем, чтобы ВСЕ 4 категории всегда были
// ----------------------------------------------------------
Future<void> _seedData() async {
  final box = Hive.box<Product>('products');

  // нормализуем категории
  bool hasFood = box.values.any(
    (p) => p.category.trim().toLowerCase() == "food",
  );
  bool hasGadget = box.values.any(
    (p) => p.category.trim().toLowerCase() == "gadget",
  );
  bool hasClothes = box.values.any(
    (p) => p.category.trim().toLowerCase() == "clothes",
  );
  bool hasHome = box.values.any(
    (p) => p.category.trim().toLowerCase() == "home",
  );

  // -------------------------------
  // ДОБАВЛЯЕМ КАЖДУЮ КАТЕГОРИЮ ЕСЛИ ЕЁ НЕТ
  // -------------------------------

  if (!hasFood) {
    box.add(
      Product(
        id: "seed_food",
        name: "Burger",
        price: 5.0,
        category: "food",
        imagePath: "",
      ),
    );
    print("Added FOOD");
  }

  if (!hasGadget) {
    box.add(
      Product(
        id: "seed_gadget",
        name: "MacBook Pro",
        price: 2000.0,
        category: "gadget",
        imagePath: "",
      ),
    );
    print("Added GADGET");
  }

  if (!hasClothes) {
    box.add(
      Product(
        id: "seed_clothes",
        name: "Jeans",
        price: 40.0,
        category: "clothes",
        imagePath: "",
      ),
    );
    print("Added CLOTHES");
  }

  // ---------- ВАЖНО: ДОБАВЛЯЕМ HOME ----------
  if (!hasHome) {
    box.add(
      Product(
        id: "seed_home",
        name: "Sofa",
        price: 300.0,
        category: "home",
        imagePath: "",
      ),
    );
    print("Added HOME");
  }

  print("FINAL CATEGORIES => ${box.values.map((e) => e.category).toSet()}");
}

// ----------------------------------------------------------
//   ОСНОВНОЕ ПРИЛОЖЕНИЕ
// ----------------------------------------------------------
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
