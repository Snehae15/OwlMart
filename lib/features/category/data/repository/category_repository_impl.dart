import 'package:owlmart/core/network/network_info.dart';
import '../../domain/entities/category_entity.dart';
import '../../domain/repository/category_repository.dart';
import '../datasource/category_local_data_source.dart';
import '../datasource/category_remote_data_source.dart';

class CategoryRepositoryImpl implements CategoryRepository {
  final CategoryRemoteDataSource remoteDataSource;
  final CategoryLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  const CategoryRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.networkInfo,
  });

  @override
  Future<CategoryEntity> getCategoryData() async {
    if (await networkInfo.isConnected) {
      final remoteData = await remoteDataSource.getCategoryFromApi();
      await localDataSource.cacheCategory(remoteData);
      return remoteData;
    } else {
      return localDataSource.getLastCategory();
    }
  }
}
