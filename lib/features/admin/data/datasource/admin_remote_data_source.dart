import '../models/admin_model.dart';

abstract class AdminRemoteDataSource {
  Future<AdminModel> getAdminFromApi();
}

class AdminRemoteDataSourceImpl implements AdminRemoteDataSource {
  const AdminRemoteDataSourceImpl();

  @override
  Future<AdminModel> getAdminFromApi() async {
    throw UnimplementedError();
  }
}
