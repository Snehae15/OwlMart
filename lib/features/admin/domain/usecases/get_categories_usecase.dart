import 'package:owlmart/core/usecase/usecase.dart';
import '../entities/category_entity.dart';
import '../repository/admin_repository.dart';

class GetCategoriesUseCase implements UseCase<List<CategoryEntity>, NoParams> {
  final AdminRepository repository;

  const GetCategoriesUseCase({required this.repository});

  @override
  Future<List<CategoryEntity>> call(NoParams params) async {
    return repository.getCategories();
  }
}
