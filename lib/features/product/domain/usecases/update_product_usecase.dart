import 'package:owlmart/core/usecase/usecase.dart';
import '../entities/product_entity.dart';
import '../repository/product_repository.dart';

class UpdateProductUseCase implements UseCase<void, ProductEntity> {
  final ProductRepository repository;

  const UpdateProductUseCase({required this.repository});

  @override
  Future<void> call(ProductEntity product) async {
    return repository.updateProduct(product);
  }
}
