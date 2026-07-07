import 'package:owlmart/core/error/exceptions.dart';
import 'package:owlmart/core/error/failures.dart';
import 'package:owlmart/core/network/network_info.dart';
import '../../domain/entities/user_entity.dart';
import '../../domain/repository/authentication_repository.dart';
import '../datasource/authentication_remote_data_source.dart';

class AuthenticationRepositoryImpl implements AuthenticationRepository {
  final AuthenticationRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  const AuthenticationRepositoryImpl({
    required this.remoteDataSource,
    required this.networkInfo,
  });

  @override
  Future<UserEntity> loginWithEmail(String email, String password) async {
    if (await networkInfo.isConnected) {
      try {
        final userModel = await remoteDataSource.loginWithEmail(email, password);
        return userModel;
      } on ServerException catch (e) {
        throw ServerFailure(e.message ?? 'Email sign-in failed');
      }
    } else {
      throw const NetworkFailure('No internet connection');
    }
  }

  @override
  Future<UserEntity> loginWithGoogle() async {
    if (await networkInfo.isConnected) {
      try {
        final userModel = await remoteDataSource.loginWithGoogle();
        return userModel;
      } on ServerException catch (e) {
        throw ServerFailure(e.message ?? 'Google sign-in failed');
      }
    } else {
      throw const NetworkFailure('No internet connection');
    }
  }

  @override
  Future<void> logout() async {
    try {
      await remoteDataSource.logout();
    } on ServerException catch (e) {
      throw ServerFailure(e.message ?? 'Logout failed');
    }
  }

  @override
  Future<UserEntity?> getCurrentUser() async {
    try {
      final userModel = await remoteDataSource.getCurrentUser();
      return userModel;
    } on ServerException catch (e) {
      throw ServerFailure(e.message ?? 'Failed to retrieve current user');
    }
  }
}
