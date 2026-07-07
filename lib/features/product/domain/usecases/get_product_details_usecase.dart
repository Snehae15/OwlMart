import 'package:owlmart/core/usecase/usecase.dart';
import '../entities/product_entity.dart';
import '../repository/product_repository.dart';

class GetProductDetailsUseCase implements UseCase<ProductEntity, String> {
  final ProductRepository repository;

  const GetProductDetailsUseCase({required this.repository});

  @override
  Future<ProductEntity> call(String id) async {
    return repository.getProductById(id);
  }
}
