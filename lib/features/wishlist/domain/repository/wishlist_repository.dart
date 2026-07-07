import '../entities/wishlist_entity.dart';

abstract class WishlistRepository {
  Future<WishlistEntity> getWishlistData();
}
