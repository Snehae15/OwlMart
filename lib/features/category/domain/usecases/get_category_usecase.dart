import 'package:owlmart/core/usecase/usecase.dart';
import '../entities/category_entity.dart';
import '../repository/category_repository.dart';

class GetCategoryUseCase implements UseCase<CategoryEntity, NoParams> {
  final CategoryRepository repository;

  const GetCategoryUseCase({required this.repository});

  @override
  Future<CategoryEntity> call(NoParams params) async {
    return repository.getCategoryData();
  }
}
