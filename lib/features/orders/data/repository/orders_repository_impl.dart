import 'package:owlmart/core/network/network_info.dart';
import '../../domain/entities/orders_entity.dart';
import '../../domain/repository/orders_repository.dart';
import '../datasource/orders_local_data_source.dart';
import '../datasource/orders_remote_data_source.dart';

class OrdersRepositoryImpl implements OrdersRepository {
  final OrdersRemoteDataSource remoteDataSource;
  final OrdersLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  const OrdersRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.networkInfo,
  });

  @override
  Future<OrdersEntity> getOrdersData() async {
    if (await networkInfo.isConnected) {
      final remoteData = await remoteDataSource.getOrdersFromApi();
      await localDataSource.cacheOrders(remoteData);
      return remoteData;
    } else {
      return localDataSource.getLastOrders();
    }
  }
}
