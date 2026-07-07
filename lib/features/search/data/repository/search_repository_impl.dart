import 'package:owlmart/core/network/network_info.dart';
import '../../domain/entities/search_entity.dart';
import '../../domain/repository/search_repository.dart';
import '../datasource/search_local_data_source.dart';
import '../datasource/search_remote_data_source.dart';

class SearchRepositoryImpl implements SearchRepository {
  final SearchRemoteDataSource remoteDataSource;
  final SearchLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  const SearchRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.networkInfo,
  });

  @override
  Future<SearchEntity> getSearchData() async {
    if (await networkInfo.isConnected) {
      final remoteData = await remoteDataSource.getSearchFromApi();
      await localDataSource.cacheSearch(remoteData);
      return remoteData;
    } else {
      return localDataSource.getLastSearch();
    }
  }
}
