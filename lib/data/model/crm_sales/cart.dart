import 'package:hive/hive.dart';

part 'cart.g.dart';

@HiveType(typeId: 0)
class Cart{
  @HiveField(0)
  final int? id;
  @HiveField(1)
  final String? title;
  @HiveField(2, defaultValue: 1)
  final int? quantity;
  @HiveField(3)
  final double? price;
  @HiveField(4)
  final String? image;

  Cart({this.id, this.title, this.price, this.quantity, this.image});

  Cart copyWith({required int quantity}) {
    return Cart(id: id, title: title, quantity: quantity, price: price, image: image);
  }

  Map<String, dynamic> toCheckoutJson() {
    return {"productId": id,  "quantity": quantity };
  }
}