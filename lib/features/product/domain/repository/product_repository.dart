import '../entities/product_entity.dart';

abstract class ProductRepository {
  Future<List<ProductEntity>> getProducts({String? category, bool? onlyEnabled});
  Future<ProductEntity> getProductById(String id);
  Future<void> addProduct(ProductEntity product);
  Future<void> updateProduct(ProductEntity product);
  Future<void> deleteProduct(String id);
  Future<void> toggleProductStatus(String id, bool isEnabled);
  Future<List<ProductEntity>> searchProducts(String query);
}
