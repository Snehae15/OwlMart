import 'package:equatable/equatable.dart';
import 'package:owlmart/core/usecase/usecase.dart';
import '../repository/admin_repository.dart';

class UpdateOrderStatusUseCase implements UseCase<void, UpdateOrderStatusParams> {
  final AdminRepository repository;

  const UpdateOrderStatusUseCase({required this.repository});

  @override
  Future<void> call(UpdateOrderStatusParams params) async {
    return repository.updateOrderStatus(params.orderId, params.status);
  }
}

class UpdateOrderStatusParams extends Equatable {
  final String orderId;
  final String status;

  const UpdateOrderStatusParams({required this.orderId, required this.status});

  @override
  List<Object?> get props => [orderId, status];
}
