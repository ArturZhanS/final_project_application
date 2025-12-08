import 'package:hive/hive.dart';

part 'db_models.g.dart';

@HiveType(typeId: 0)
class Product extends HiveObject {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String name;

  @HiveField(2)
  final double price;

  @HiveField(3)
  final String category;

  @HiveField(4)
  final String imagePath;

  Product({
    required this.id,
    required this.name,
    required this.price,
    required this.category,
    required this.imagePath,
  });
}

@HiveType(typeId: 1)
class PaymentCard extends HiveObject {
  @HiveField(0)
  final String cardNumber;

  @HiveField(1)
  final double balance;

  PaymentCard({required this.cardNumber, required this.balance});
}
