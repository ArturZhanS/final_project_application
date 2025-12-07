import 'package:flutter/foundation.dart';

// Убедитесь, что этот путь к вашей модели Product верный
// (В зависимости от того, где лежит db_models.dart или product.dart)
// Возможно, вам нужно импортировать 'package:final_project_application/models/product.dart'
import '../models/db_models.dart'; // Изменен импорт на более общий путь

// --- ИЗМЕНЕНИЕ: Класс переименован в CartService для соответствия main.dart ---
// --- УДАЛЕНИЕ: Паттерн Singleton удален, так как Provider сам управляет экземпляром ---

class CartService extends ChangeNotifier {
  // Инициализация стандартным конструктором
  CartService();

  // Карта: {ID продукта: Количество}
  final Map<String, int> _quantities = {};
  // Карта: {ID продукта: Объект Product}
  final Map<String, Product> _products = {};

  // Получение списка продуктов в корзине
  List<Product> get items => _products.values.toList();

  // Получение количества конкретного продукта
  int getQuantity(Product p) => _quantities[p.id] ?? 0;

  void addToCart(Product product) {
    // Изменено с Card на Cart
    if (_products.containsKey(product.id)) {
      _quantities[product.id] = (_quantities[product.id] ?? 0) + 1;
    } else {
      _quantities[product.id] = 1;
      _products[product.id] = product;
    }

    notifyListeners();
  }

  void removeFromCart(Product product) {
    // Изменено с Card на Cart
    if (!_quantities.containsKey(product.id)) return;

    if (_quantities[product.id]! > 1) {
      _quantities[product.id] = (_quantities[product.id] ?? 0) - 1;
    } else {
      _quantities.remove(product.id);
      _products.remove(product.id);
    }
    notifyListeners();
  }

  double get totalAmount {
    double total = 0;
    _products.forEach((id, product) {
      total += product.price * (_quantities[id] ?? 0);
    });
    return total;
  }

  void clear() {
    _quantities.clear();
    _products.clear();
    notifyListeners();
  }
}
