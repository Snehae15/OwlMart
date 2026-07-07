import 'package:equatable/equatable.dart';
import 'package:owlmart/core/usecase/usecase.dart';
import '../repository/wishlist_repository.dart';

class RemoveFromWishlistUseCase implements UseCase<void, RemoveFromWishlistParams> {
  final WishlistRepository repository;

  const RemoveFromWishlistUseCase({required this.repository});

  @override
  Future<void> call(RemoveFromWishlistParams params) async {
    return repository.removeFromWishlist(params.userId, params.productId);
  }
}

class RemoveFromWishlistParams extends Equatable {
  final String userId;
  final String productId;

  const RemoveFromWishlistParams({required this.userId, required this.productId});

  @override
  List<Object?> get props => [userId, productId];
}
