import '../entities/category_entity.dart';

abstract class CategoryRepository {
  Future<CategoryEntity> getCategoryData();
}
