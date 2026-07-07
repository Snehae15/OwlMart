import 'package:equatable/equatable.dart';
import 'package:owlmart/core/usecase/usecase.dart';
import '../entities/product_entity.dart';
import '../repository/product_repository.dart';

class GetProductsUseCase implements UseCase<List<ProductEntity>, GetProductsParams> {
  final ProductRepository repository;

  const GetProductsUseCase({required this.repository});

  @override
  Future<List<ProductEntity>> call(GetProductsParams params) async {
    return repository.getProducts(category: params.category, onlyEnabled: params.onlyEnabled);
  }
}

class GetProductsParams extends Equatable {
  final String? category;
  final bool? onlyEnabled;

  const GetProductsParams({this.category, this.onlyEnabled});

  @override
  List<Object?> get props => [category, onlyEnabled];
}
