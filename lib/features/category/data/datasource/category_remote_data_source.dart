import '../models/category_model.dart';

abstract class CategoryRemoteDataSource {
  Future<CategoryModel> getCategoryFromApi();
}

class CategoryRemoteDataSourceImpl implements CategoryRemoteDataSource {
  const CategoryRemoteDataSourceImpl();

  @override
  Future<CategoryModel> getCategoryFromApi() async {
    throw UnimplementedError();
  }
}
