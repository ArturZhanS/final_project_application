import 'package:flutter/material.dart';
import 'package:provider/provider.dart'; // Импортируем provider
import 'screens/main_nav_screen.dart'; // Импортируем ваш главный навигационный экран
import 'services/cart_service.dart'; // Импортируем сервис корзины (Receiver)

void main() {
  runApp(
    // Оборачиваем все приложение в ChangeNotifierProvider.
    // Это делает CartService доступным для всех виджетов (экранов),
    // где мы используем Command Pattern (SubProductScreen, CardScreen).
    ChangeNotifierProvider(
      // Создаем экземпляр CartService
      create: (context) => CartService(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Final E-commerce Project',
      // Наследуем базовую темную тему (как в вашем Abstract Factory)
      theme: ThemeData(brightness: Brightness.dark, useMaterial3: true),
      // Устанавливаем MainNavScreen как домашний экран
      home: const MainNavScreen(),
    );
  }
}
