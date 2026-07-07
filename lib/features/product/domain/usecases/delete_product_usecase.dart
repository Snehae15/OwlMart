import 'package:owlmart/core/usecase/usecase.dart';
import '../repository/product_repository.dart';

class DeleteProductUseCase implements UseCase<void, String> {
  final ProductRepository repository;

  const DeleteProductUseCase({required this.repository});

  @override
  Future<void> call(String id) async {
    return repository.deleteProduct(id);
  }
}
