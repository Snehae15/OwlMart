import '../models/wishlist_item_model.dart';

abstract class WishlistLocalDataSource {
  Future<List<WishlistItemModel>> getLastWishlist();
  Future<void> cacheWishlist(List<WishlistItemModel> itemsToCache);
}

class WishlistLocalDataSourceImpl implements WishlistLocalDataSource {
  const WishlistLocalDataSourceImpl();

  @override
  Future<List<WishlistItemModel>> getLastWishlist() async {
    throw UnimplementedError();
  }

  @override
  Future<void> cacheWishlist(List<WishlistItemModel> itemsToCache) async {
    throw UnimplementedError();
  }
}
