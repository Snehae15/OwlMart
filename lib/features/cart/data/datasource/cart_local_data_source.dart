import '../models/cart_model.dart';

abstract class CartLocalDataSource {
  Future<CartModel> getLastCart();
  Future<void> cacheCart(CartModel modelToCache);
}

class CartLocalDataSourceImpl implements CartLocalDataSource {
  const CartLocalDataSourceImpl();

  @override
  Future<CartModel> getLastCart() async {
    throw UnimplementedError();
  }

  @override
  Future<void> cacheCart(CartModel modelToCache) async {
    throw UnimplementedError();
  }
}
