import '../models/search_model.dart';

abstract class SearchRemoteDataSource {
  Future<SearchModel> getSearchFromApi();
}

class SearchRemoteDataSourceImpl implements SearchRemoteDataSource {
  const SearchRemoteDataSourceImpl();

  @override
  Future<SearchModel> getSearchFromApi() async {
    throw UnimplementedError();
  }
}
