import '../models/user_model.dart';

abstract class AuthenticationLocalDataSource {
  Future<UserModel> getLastAuthentication();
  Future<void> cacheAuthentication(UserModel modelToCache);
}

class AuthenticationLocalDataSourceImpl implements AuthenticationLocalDataSource {
  const AuthenticationLocalDataSourceImpl();

  @override
  Future<UserModel> getLastAuthentication() async {
    throw UnimplementedError();
  }

  @override
  Future<void> cacheAuthentication(UserModel modelToCache) async {
    throw UnimplementedError();
  }
}
