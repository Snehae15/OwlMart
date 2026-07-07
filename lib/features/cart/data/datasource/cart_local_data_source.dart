import '../models/cart_item_model.dart';

abstract class CartLocalDataSource {
  Future<List<CartItemModel>> getLastCart();
  Future<void> cacheCart(List<CartItemModel> itemsToCache);
}

class CartLocalDataSourceImpl implements CartLocalDataSource {
  const CartLocalDataSourceImpl();

  @override
  Future<List<CartItemModel>> getLastCart() async {
    throw UnimplementedError();
  }

  @override
  Future<void> cacheCart(List<CartItemModel> itemsToCache) async {
    throw UnimplementedError();
  }
}
