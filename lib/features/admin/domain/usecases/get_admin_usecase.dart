import 'package:owlmart/core/usecase/usecase.dart';
import '../entities/admin_entity.dart';
import '../repository/admin_repository.dart';

class GetAdminUseCase implements UseCase<AdminEntity, NoParams> {
  final AdminRepository repository;

  const GetAdminUseCase({required this.repository});

  @override
  Future<AdminEntity> call(NoParams params) async {
    return repository.getAdminData();
  }
}
