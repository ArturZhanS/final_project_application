import 'package:flutter/foundation.dart';
import '../models/db_models.dart';

class CardService extends ChangeNotifier {
  static final CardService _instance = CardService._internal();
  factory CardService() {
    return _instance;
  }
  CardService._internal();

  final Map<String, int> _quantities = {};
  final Map<String, Product> _products = {};
  List<Product> get items => _products.values.toList();
  int getQuantity(Product p) => _quantities[p.id] ?? 0;

  void addToCard(Product product) {
    if (_products.containsKey(product.id)) {
      _quantities[product.id] = (_quantities[product.id] ?? 0) + 1;
    } else {
      _quantities[product.id] = 1;
      _products[product.id] = product;
    }

    notifyListeners();
  }

  void removeFromCard(Product product) {
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
