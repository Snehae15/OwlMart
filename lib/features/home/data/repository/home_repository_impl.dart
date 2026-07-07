import 'package:owlmart/core/network/network_info.dart';
import '../../domain/entities/home_entity.dart';
import '../../domain/repository/home_repository.dart';
import '../datasource/home_local_data_source.dart';
import '../datasource/home_remote_data_source.dart';

class HomeRepositoryImpl implements HomeRepository {
  final HomeRemoteDataSource remoteDataSource;
  final HomeLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  const HomeRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.networkInfo,
  });

  @override
  Future<HomeEntity> getHomeData() async {
    if (await networkInfo.isConnected) {
      final remoteData = await remoteDataSource.getHomeFromApi();
      await localDataSource.cacheHome(remoteData);
      return remoteData;
    } else {
      return localDataSource.getLastHome();
    }
  }
}
