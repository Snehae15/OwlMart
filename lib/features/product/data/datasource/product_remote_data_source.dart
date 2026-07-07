import '../models/product_model.dart';

abstract class ProductRemoteDataSource {
  Future<ProductModel> getProductFromApi();
}

class ProductRemoteDataSourceImpl implements ProductRemoteDataSource {
  const ProductRemoteDataSourceImpl();

  @override
  Future<ProductModel> getProductFromApi() async {
    throw UnimplementedError();
  }
}
