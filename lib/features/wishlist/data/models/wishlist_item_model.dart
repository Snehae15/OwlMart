import 'package:cloud_firestore/cloud_firestore.dart';
import '../../domain/entities/wishlist_item_entity.dart';

class WishlistItemModel extends WishlistItemEntity {
  const WishlistItemModel({
    required super.productId,
    required super.productName,
    required super.price,
    required super.imageUrl,
    required super.addedAt,
  });

  factory WishlistItemModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>? ?? {};
    return WishlistItemModel(
      productId: doc.id,
      productName: data['productName'] as String? ?? '',
      price: (data['price'] as num? ?? 0.0).toDouble(),
      imageUrl: data['imageUrl'] as String? ?? '',
      addedAt: data['addedAt'] != null
          ? (data['addedAt'] as Timestamp).toDate()
          : DateTime.now(),
    );
  }

  factory WishlistItemModel.fromEntity(WishlistItemEntity entity) {
    return WishlistItemModel(
      productId: entity.productId,
      productName: entity.productName,
      price: entity.price,
      imageUrl: entity.imageUrl,
      addedAt: entity.addedAt,
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'productName': productName,
      'price': price,
      'imageUrl': imageUrl,
      'addedAt': Timestamp.fromDate(addedAt),
    };
  }
}
