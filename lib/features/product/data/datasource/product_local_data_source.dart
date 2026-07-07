import '../models/product_model.dart';

abstract class ProductLocalDataSource {
  Future<ProductModel> getLastProduct();
  Future<void> cacheProduct(ProductModel modelToCache);
}

class ProductLocalDataSourceImpl implements ProductLocalDataSource {
  const ProductLocalDataSourceImpl();

  @override
  Future<ProductModel> getLastProduct() async {
    throw UnimplementedError();
  }

  @override
  Future<void> cacheProduct(ProductModel modelToCache) async {
    throw UnimplementedError();
  }
}
