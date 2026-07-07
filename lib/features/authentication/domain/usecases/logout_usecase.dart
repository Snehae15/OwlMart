import 'package:owlmart/core/usecase/usecase.dart';
import '../repository/authentication_repository.dart';

class LogoutUseCase implements UseCase<void, NoParams> {
  final AuthenticationRepository repository;

  const LogoutUseCase({required this.repository});

  @override
  Future<void> call(NoParams params) async {
    return repository.logout();
  }
}
