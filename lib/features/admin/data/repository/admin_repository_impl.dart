import 'package:owlmart/core/network/network_info.dart';
import '../../domain/entities/admin_entity.dart';
import '../../domain/repository/admin_repository.dart';
import '../datasource/admin_local_data_source.dart';
import '../datasource/admin_remote_data_source.dart';

class AdminRepositoryImpl implements AdminRepository {
  final AdminRemoteDataSource remoteDataSource;
  final AdminLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  const AdminRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.networkInfo,
  });

  @override
  Future<AdminEntity> getAdminData() async {
    if (await networkInfo.isConnected) {
      final remoteData = await remoteDataSource.getAdminFromApi();
      await localDataSource.cacheAdmin(remoteData);
      return remoteData;
    } else {
      return localDataSource.getLastAdmin();
    }
  }
}
