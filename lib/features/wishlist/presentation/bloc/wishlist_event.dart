import 'package:equatable/equatable.dart';
import '../../domain/entities/wishlist_item_entity.dart';

abstract class WishlistEvent extends Equatable {
  const WishlistEvent();

  @override
  List<Object?> get props => [];
}

class LoadWishlistEvent extends WishlistEvent {
  final String userId;

  const LoadWishlistEvent({required this.userId});

  @override
  List<Object?> get props => [userId];
}

class AddItemToWishlistEvent extends WishlistEvent {
  final String userId;
  final WishlistItemEntity item;

  const AddItemToWishlistEvent({required this.userId, required this.item});

  @override
  List<Object?> get props => [userId, item];
}

class RemoveItemFromWishlistEvent extends WishlistEvent {
  final String userId;
  final String productId;

  const RemoveItemFromWishlistEvent({required this.userId, required this.productId});

  @override
  List<Object?> get props => [userId, productId];
}
