import 'package:equatable/equatable.dart';
import '../../domain/entities/wishlist_item_entity.dart';

abstract class WishlistState extends Equatable {
  const WishlistState();

  @override
  List<Object?> get props => [];
}

class WishlistInitial extends WishlistState {
  const WishlistInitial();
}

class WishlistLoading extends WishlistState {
  const WishlistLoading();
}

class WishlistLoaded extends WishlistState {
  final List<WishlistItemEntity> items;

  const WishlistLoaded({required this.items});

  @override
  List<Object?> get props => [items];
}

class WishlistOperationSuccess extends WishlistState {
  final String message;

  const WishlistOperationSuccess({required this.message});

  @override
  List<Object?> get props => [message];
}

class WishlistError extends WishlistState {
  final String message;

  const WishlistError({required this.message});

  @override
  List<Object?> get props => [message];
}
