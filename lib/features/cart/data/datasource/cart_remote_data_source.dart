import '../models/cart_model.dart';

abstract class CartRemoteDataSource {
  Future<CartModel> getCartFromApi();
}

class CartRemoteDataSourceImpl implements CartRemoteDataSource {
  const CartRemoteDataSourceImpl();

  @override
  Future<CartModel> getCartFromApi() async {
    throw UnimplementedError();
  }
}
