import 'package:cloud_firestore/cloud_firestore.dart';
import '../../domain/entities/cart_item_entity.dart';

class CartItemModel extends CartItemEntity {
  const CartItemModel({
    required super.productId,
    required super.productName,
    required super.price,
    required super.imageUrl,
    required super.quantity,
  });

  factory CartItemModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>? ?? {};
    return CartItemModel(
      productId: doc.id,
      productName: data['productName'] as String? ?? '',
      price: (data['price'] as num? ?? 0.0).toDouble(),
      imageUrl: data['imageUrl'] as String? ?? '',
      quantity: data['quantity'] as int? ?? 1,
    );
  }

  factory CartItemModel.fromEntity(CartItemEntity entity) {
    return CartItemModel(
      productId: entity.productId,
      productName: entity.productName,
      price: entity.price,
      imageUrl: entity.imageUrl,
      quantity: entity.quantity,
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'productName': productName,
      'price': price,
      'imageUrl': imageUrl,
      'quantity': quantity,
    };
  }

  factory CartItemModel.fromJson(Map<String, dynamic> json) {
    return CartItemModel(
      productId: json['productId'] as String? ?? '',
      productName: json['productName'] as String? ?? '',
      price: (json['price'] as num? ?? 0.0).toDouble(),
      imageUrl: json['imageUrl'] as String? ?? '',
      quantity: json['quantity'] as int? ?? 1,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'productId': productId,
      'productName': productName,
      'price': price,
      'imageUrl': imageUrl,
      'quantity': quantity,
    };
  }
}
