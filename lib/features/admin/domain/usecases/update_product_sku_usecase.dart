import 'package:equatable/equatable.dart';
import 'package:owlmart/core/usecase/usecase.dart';
import '../repository/admin_repository.dart';

class UpdateProductSkuUseCase implements UseCase<void, UpdateProductSkuParams> {
  final AdminRepository repository;

  const UpdateProductSkuUseCase({required this.repository});

  @override
  Future<void> call(UpdateProductSkuParams params) async {
    return repository.updateSku(params.productId, params.sku);
  }
}

class UpdateProductSkuParams extends Equatable {
  final String productId;
  final String sku;

  const UpdateProductSkuParams({required this.productId, required this.sku});

  @override
  List<Object?> get props => [productId, sku];
}
