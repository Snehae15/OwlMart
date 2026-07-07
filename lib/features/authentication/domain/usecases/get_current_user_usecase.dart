import 'package:owlmart/core/usecase/usecase.dart';
import '../entities/user_entity.dart';
import '../repository/authentication_repository.dart';

class GetCurrentUserUseCase implements UseCase<UserEntity?, NoParams> {
  final AuthenticationRepository repository;

  const GetCurrentUserUseCase({required this.repository});

  @override
  Future<UserEntity?> call(NoParams params) async {
    return repository.getCurrentUser();
  }
}
