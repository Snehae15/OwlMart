import 'package:owlmart/core/network/network_info.dart';
import '../../domain/entities/product_entity.dart';
import '../../domain/repository/product_repository.dart';
import '../datasource/product_local_data_source.dart';
import '../datasource/product_remote_data_source.dart';

class ProductRepositoryImpl implements ProductRepository {
  final ProductRemoteDataSource remoteDataSource;
  final ProductLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  const ProductRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.networkInfo,
  });

  @override
  Future<ProductEntity> getProductData() async {
    if (await networkInfo.isConnected) {
      final remoteData = await remoteDataSource.getProductFromApi();
      await localDataSource.cacheProduct(remoteData);
      return remoteData;
    } else {
      return localDataSource.getLastProduct();
    }
  }
}
