import '../entities/wishlist_item_entity.dart';

abstract class WishlistRepository {
  Future<List<WishlistItemEntity>> getWishlist(String userId);
  Future<void> addToWishlist(String userId, WishlistItemEntity item);
  Future<void> removeFromWishlist(String userId, String productId);
  Future<bool> isWishlisted(String userId, String productId);
}
