import '../models/home_model.dart';

abstract class HomeRemoteDataSource {
  Future<HomeModel> getHomeFromApi();
}

class HomeRemoteDataSourceImpl implements HomeRemoteDataSource {
  const HomeRemoteDataSourceImpl();

  @override
  Future<HomeModel> getHomeFromApi() async {
    throw UnimplementedError();
  }
}
