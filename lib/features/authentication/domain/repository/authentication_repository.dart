import '../entities/user_entity.dart';

abstract class AuthenticationRepository {
  Future<UserEntity> loginWithEmail(String email, String password);
  Future<UserEntity> loginWithGoogle();
  Future<void> logout();
  Future<UserEntity?> getCurrentUser();
}
