import 'package:owlmart/core/usecase/usecase.dart';
import '../entities/product_entity.dart';
import '../repository/product_repository.dart';

class GetProductUseCase implements UseCase<ProductEntity, NoParams> {
  final ProductRepository repository;

  const GetProductUseCase({required this.repository});

  @override
  Future<ProductEntity> call(NoParams params) async {
    return repository.getProductData();
  }
}
