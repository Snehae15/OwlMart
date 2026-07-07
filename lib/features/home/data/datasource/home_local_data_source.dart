import '../models/home_model.dart';

abstract class HomeLocalDataSource {
  Future<HomeModel> getLastHome();
  Future<void> cacheHome(HomeModel modelToCache);
}

class HomeLocalDataSourceImpl implements HomeLocalDataSource {
  const HomeLocalDataSourceImpl();

  @override
  Future<HomeModel> getLastHome() async {
    throw UnimplementedError();
  }

  @override
  Future<void> cacheHome(HomeModel modelToCache) async {
    throw UnimplementedError();
  }
}
