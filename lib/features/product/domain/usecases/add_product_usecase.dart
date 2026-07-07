import 'package:owlmart/core/usecase/usecase.dart';
import '../entities/product_entity.dart';
import '../repository/product_repository.dart';

class AddProductUseCase implements UseCase<void, ProductEntity> {
  final ProductRepository repository;

  const AddProductUseCase({required this.repository});

  @override
  Future<void> call(ProductEntity product) async {
    return repository.addProduct(product);
  }
}
