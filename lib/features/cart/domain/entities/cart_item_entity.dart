import 'package:equatable/equatable.dart';

class CartItemEntity extends Equatable {
  final String productId;
  final String productName;
  final double price;
  final String imageUrl;
  final int quantity;

  const CartItemEntity({
    required this.productId,
    required this.productName,
    required this.price,
    required this.imageUrl,
    required this.quantity,
  });

  double get totalPrice => price * quantity;

  @override
  List<Object?> get props => [productId, productName, price, imageUrl, quantity];
}
