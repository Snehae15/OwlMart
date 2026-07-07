import 'package:owlmart/core/usecase/usecase.dart';
import '../entities/wishlist_entity.dart';
import '../repository/wishlist_repository.dart';

class GetWishlistUseCase implements UseCase<WishlistEntity, NoParams> {
  final WishlistRepository repository;

  const GetWishlistUseCase({required this.repository});

  @override
  Future<WishlistEntity> call(NoParams params) async {
    return repository.getWishlistData();
  }
}
