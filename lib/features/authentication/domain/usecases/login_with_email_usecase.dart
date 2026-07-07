import 'package:equatable/equatable.dart';
import 'package:owlmart/core/usecase/usecase.dart';
import '../entities/user_entity.dart';
import '../repository/authentication_repository.dart';

class LoginWithEmailUseCase implements UseCase<UserEntity, LoginWithEmailParams> {
  final AuthenticationRepository repository;

  const LoginWithEmailUseCase({required this.repository});

  @override
  Future<UserEntity> call(LoginWithEmailParams params) async {
    return repository.loginWithEmail(params.email, params.password);
  }
}

class LoginWithEmailParams extends Equatable {
  final String email;
  final String password;

  const LoginWithEmailParams({required this.email, required this.password});

  @override
  List<Object?> get props => [email, password];
}
