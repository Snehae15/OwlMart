import 'package:equatable/equatable.dart';
import 'package:owlmart/core/usecase/usecase.dart';
import '../repository/admin_repository.dart';

class UpdateProductStockUseCase implements UseCase<void, UpdateProductStockParams> {
  final AdminRepository repository;

  const UpdateProductStockUseCase({required this.repository});

  @override
  Future<void> call(UpdateProductStockParams params) async {
    return repository.updateStock(params.productId, params.newStock);
  }
}

class UpdateProductStockParams extends Equatable {
  final String productId;
  final int newStock;

  const UpdateProductStockParams({required this.productId, required this.newStock});

  @override
  List<Object?> get props => [productId, newStock];
}
