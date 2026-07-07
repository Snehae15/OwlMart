import 'package:owlmart/core/usecase/usecase.dart';
import '../entities/product_entity.dart';
import '../repository/product_repository.dart';

class SearchProductsUseCase implements UseCase<List<ProductEntity>, String> {
  final ProductRepository repository;

  const SearchProductsUseCase({required this.repository});

  @override
  Future<List<ProductEntity>> call(String query) async {
    return repository.searchProducts(query);
  }
}
