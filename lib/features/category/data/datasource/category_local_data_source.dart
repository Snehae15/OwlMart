import '../models/category_model.dart';

abstract class CategoryLocalDataSource {
  Future<CategoryModel> getLastCategory();
  Future<void> cacheCategory(CategoryModel modelToCache);
}

class CategoryLocalDataSourceImpl implements CategoryLocalDataSource {
  const CategoryLocalDataSourceImpl();

  @override
  Future<CategoryModel> getLastCategory() async {
    throw UnimplementedError();
  }

  @override
  Future<void> cacheCategory(CategoryModel modelToCache) async {
    throw UnimplementedError();
  }
}
