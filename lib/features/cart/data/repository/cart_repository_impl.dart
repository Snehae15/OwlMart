import 'package:owlmart/core/network/network_info.dart';
import '../../domain/entities/cart_entity.dart';
import '../../domain/repository/cart_repository.dart';
import '../datasource/cart_local_data_source.dart';
import '../datasource/cart_remote_data_source.dart';

class CartRepositoryImpl implements CartRepository {
  final CartRemoteDataSource remoteDataSource;
  final CartLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  const CartRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.networkInfo,
  });

  @override
  Future<CartEntity> getCartData() async {
    if (await networkInfo.isConnected) {
      final remoteData = await remoteDataSource.getCartFromApi();
      await localDataSource.cacheCart(remoteData);
      return remoteData;
    } else {
      return localDataSource.getLastCart();
    }
  }
}
