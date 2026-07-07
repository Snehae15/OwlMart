import 'package:equatable/equatable.dart';
import '../../domain/entities/cart_item_entity.dart';

abstract class CartEvent extends Equatable {
  const CartEvent();

  @override
  List<Object?> get props => [];
}

class LoadCartEvent extends CartEvent {
  final String userId;

  const LoadCartEvent({required this.userId});

  @override
  List<Object?> get props => [userId];
}

class AddItemToCartEvent extends CartEvent {
  final String userId;
  final CartItemEntity item;

  const AddItemToCartEvent({required this.userId, required this.item});

  @override
  List<Object?> get props => [userId, item];
}

class RemoveItemFromCartEvent extends CartEvent {
  final String userId;
  final String productId;

  const RemoveItemFromCartEvent({required this.userId, required this.productId});

  @override
  List<Object?> get props => [userId, productId];
}

class UpdateItemQuantityEvent extends CartEvent {
  final String userId;
  final String productId;
  final int quantity;

  const UpdateItemQuantityEvent({
    required this.userId,
    required this.productId,
    required this.quantity,
  });

  @override
  List<Object?> get props => [userId, productId, quantity];
}

class ClearCartItemsEvent extends CartEvent {
  final String userId;

  const ClearCartItemsEvent({required this.userId});

  @override
  List<Object?> get props => [userId];
}
