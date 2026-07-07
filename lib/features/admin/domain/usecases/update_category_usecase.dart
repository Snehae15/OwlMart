import 'package:owlmart/core/usecase/usecase.dart';
import '../entities/category_entity.dart';
import '../repository/admin_repository.dart';

class UpdateCategoryUseCase implements UseCase<void, CategoryEntity> {
  final AdminRepository repository;

  const UpdateCategoryUseCase({required this.repository});

  @override
  Future<void> call(CategoryEntity category) async {
    return repository.updateCategory(category);
  }
}
