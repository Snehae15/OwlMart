import 'package:equatable/equatable.dart';
import 'package:owlmart/core/usecase/usecase.dart';
import '../entities/wishlist_item_entity.dart';
import '../repository/wishlist_repository.dart';

class AddToWishlistUseCase implements UseCase<void, AddToWishlistParams> {
  final WishlistRepository repository;

  const AddToWishlistUseCase({required this.repository});

  @override
  Future<void> call(AddToWishlistParams params) async {
    return repository.addToWishlist(params.userId, params.item);
  }
}

class AddToWishlistParams extends Equatable {
  final String userId;
  final WishlistItemEntity item;

  const AddToWishlistParams({required this.userId, required this.item});

  @override
  List<Object?> get props => [userId, item];
}
