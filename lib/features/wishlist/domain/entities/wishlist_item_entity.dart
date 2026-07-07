import 'package:equatable/equatable.dart';

class WishlistItemEntity extends Equatable {
  final String productId;
  final String productName;
  final double price;
  final String imageUrl;
  final DateTime addedAt;

  const WishlistItemEntity({
    required this.productId,
    required this.productName,
    required this.price,
    required this.imageUrl,
    required this.addedAt,
  });

  @override
  List<Object?> get props => [productId, productName, price, imageUrl, addedAt];
}
