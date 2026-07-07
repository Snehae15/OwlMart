import 'package:owlmart/core/usecase/usecase.dart';
import '../entities/user_entity.dart';
import '../repository/authentication_repository.dart';

class LoginWithGoogleUseCase implements UseCase<UserEntity, NoParams> {
  final AuthenticationRepository repository;

  const LoginWithGoogleUseCase({required this.repository});

  @override
  Future<UserEntity> call(NoParams params) async {
    return repository.loginWithGoogle();
  }
}
