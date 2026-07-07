import 'package:equatable/equatable.dart';

abstract class WishlistEvent extends Equatable {
  const WishlistEvent();

  @override
  List<Object?> get props => [];
}

class GetWishlistDataEvent extends WishlistEvent {
  const GetWishlistDataEvent();
}
