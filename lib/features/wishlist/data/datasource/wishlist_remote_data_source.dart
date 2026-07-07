import '../models/wishlist_model.dart';

abstract class WishlistRemoteDataSource {
  Future<WishlistModel> getWishlistFromApi();
}

class WishlistRemoteDataSourceImpl implements WishlistRemoteDataSource {
  const WishlistRemoteDataSourceImpl();

  @override
  Future<WishlistModel> getWishlistFromApi() async {
    throw UnimplementedError();
  }
}
