import '../models/wishlist_model.dart';

abstract class WishlistLocalDataSource {
  Future<WishlistModel> getLastWishlist();
  Future<void> cacheWishlist(WishlistModel modelToCache);
}

class WishlistLocalDataSourceImpl implements WishlistLocalDataSource {
  const WishlistLocalDataSourceImpl();

  @override
  Future<WishlistModel> getLastWishlist() async {
    throw UnimplementedError();
  }

  @override
  Future<void> cacheWishlist(WishlistModel modelToCache) async {
    throw UnimplementedError();
  }
}
