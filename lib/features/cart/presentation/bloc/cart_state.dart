import 'package:equatable/equatable.dart';
import '../../domain/entities/cart_item_entity.dart';

abstract class CartState extends Equatable {
  const CartState();

  @override
  List<Object?> get props => [];
}

class CartInitial extends CartState {
  const CartInitial();
}

class CartLoading extends CartState {
  const CartLoading();
}

class CartLoaded extends CartState {
  final List<CartItemEntity> items;
  final double totalPrice;

  const CartLoaded({required this.items, required this.totalPrice});

  @override
  List<Object?> get props => [items, totalPrice];
}

class CartOperationSuccess extends CartState {
  final String message;

  const CartOperationSuccess({required this.message});

  @override
  List<Object?> get props => [message];
}

class CartError extends CartState {
  final String message;

  const CartError({required this.message});

  @override
  List<Object?> get props => [message];
}
