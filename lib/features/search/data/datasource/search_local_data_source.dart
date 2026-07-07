import '../models/search_model.dart';

abstract class SearchLocalDataSource {
  Future<SearchModel> getLastSearch();
  Future<void> cacheSearch(SearchModel modelToCache);
}

class SearchLocalDataSourceImpl implements SearchLocalDataSource {
  const SearchLocalDataSourceImpl();

  @override
  Future<SearchModel> getLastSearch() async {
    throw UnimplementedError();
  }

  @override
  Future<void> cacheSearch(SearchModel modelToCache) async {
    throw UnimplementedError();
  }
}
