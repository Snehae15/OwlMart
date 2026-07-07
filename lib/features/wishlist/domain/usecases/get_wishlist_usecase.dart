import 'package:owlmart/core/usecase/usecase.dart';
import '../entities/wishlist_item_entity.dart';
import '../repository/wishlist_repository.dart';

class GetWishlistUseCase implements UseCase<List<WishlistItemEntity>, String> {
  final WishlistRepository repository;

  const GetWishlistUseCase({required this.repository});

  @override
  Future<List<WishlistItemEntity>> call(String userId) async {
    return repository.getWishlist(userId);
  }
}
