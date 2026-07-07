import 'package:owlmart/core/error/exceptions.dart';
import 'package:owlmart/core/error/failures.dart';
import 'package:owlmart/core/network/network_info.dart';
import '../../domain/entities/product_entity.dart';
import '../../domain/repository/product_repository.dart';
import '../datasource/product_remote_data_source.dart';
import '../models/product_model.dart';

class ProductRepositoryImpl implements ProductRepository {
  final ProductRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  const ProductRepositoryImpl({
    required this.remoteDataSource,
    required this.networkInfo,
  });

  @override
  Future<List<ProductEntity>> getProducts({String? category, bool? onlyEnabled}) async {
    if (await networkInfo.isConnected) {
      try {
        final products = await remoteDataSource.getProducts(
          category: category,
          onlyEnabled: onlyEnabled,
        );
        return products;
      } on ServerException catch (e) {
        throw ServerFailure(e.message ?? 'Failed to load products');
      }
    } else {
      throw const NetworkFailure('No internet connection');
    }
  }

  @override
  Future<ProductEntity> getProductById(String id) async {
    if (await networkInfo.isConnected) {
      try {
        final product = await remoteDataSource.getProductById(id);
        return product;
      } on ServerException catch (e) {
        throw ServerFailure(e.message ?? 'Failed to load product details');
      }
    } else {
      throw const NetworkFailure('No internet connection');
    }
  }

  @override
  Future<void> addProduct(ProductEntity product) async {
    if (await networkInfo.isConnected) {
      try {
        final model = ProductModel.fromEntity(product);
        await remoteDataSource.addProduct(model);
      } on ServerException catch (e) {
        throw ServerFailure(e.message ?? 'Failed to add product');
      }
    } else {
      throw const NetworkFailure('No internet connection');
    }
  }

  @override
  Future<void> updateProduct(ProductEntity product) async {
    if (await networkInfo.isConnected) {
      try {
        final model = ProductModel.fromEntity(product);
        await remoteDataSource.updateProduct(model);
      } on ServerException catch (e) {
        throw ServerFailure(e.message ?? 'Failed to update product');
      }
    } else {
      throw const NetworkFailure('No internet connection');
    }
  }

  @override
  Future<void> deleteProduct(String id) async {
    if (await networkInfo.isConnected) {
      try {
        await remoteDataSource.deleteProduct(id);
      } on ServerException catch (e) {
        throw ServerFailure(e.message ?? 'Failed to delete product');
      }
    } else {
      throw const NetworkFailure('No internet connection');
    }
  }

  @override
  Future<void> toggleProductStatus(String id, bool isEnabled) async {
    if (await networkInfo.isConnected) {
      try {
        await remoteDataSource.toggleProductStatus(id, isEnabled);
      } on ServerException catch (e) {
        throw ServerFailure(e.message ?? 'Failed to update product status');
      }
    } else {
      throw const NetworkFailure('No internet connection');
    }
  }

  @override
  Future<List<ProductEntity>> searchProducts(String query) async {
    if (await networkInfo.isConnected) {
      try {
        final products = await remoteDataSource.searchProducts(query);
        return products;
      } on ServerException catch (e) {
        throw ServerFailure(e.message ?? 'Product search failed');
      }
    } else {
      throw const NetworkFailure('No internet connection');
    }
  }
}
