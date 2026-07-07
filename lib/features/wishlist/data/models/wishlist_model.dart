import '../../domain/entities/wishlist_entity.dart';

class WishlistModel extends WishlistEntity {
  const WishlistModel({required super.id});

  factory WishlistModel.fromJson(Map<String, dynamic> json) {
    return WishlistModel(
      id: json['id'] as String? ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
    };
  }
}
