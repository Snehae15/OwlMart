import 'package:owlmart/core/usecase/usecase.dart';
import '../repository/admin_repository.dart';

class DeleteCategoryUseCase implements UseCase<void, String> {
  final AdminRepository repository;

  const DeleteCategoryUseCase({required this.repository});

  @override
  Future<void> call(String id) async {
    return repository.deleteCategory(id);
  }
}
