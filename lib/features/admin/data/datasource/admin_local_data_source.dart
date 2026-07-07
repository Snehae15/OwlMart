import '../models/admin_model.dart';

abstract class AdminLocalDataSource {
  Future<AdminModel> getLastAdmin();
  Future<void> cacheAdmin(AdminModel modelToCache);
}

class AdminLocalDataSourceImpl implements AdminLocalDataSource {
  const AdminLocalDataSourceImpl();

  @override
  Future<AdminModel> getLastAdmin() async {
    throw UnimplementedError();
  }

  @override
  Future<void> cacheAdmin(AdminModel modelToCache) async {
    throw UnimplementedError();
  }
}
