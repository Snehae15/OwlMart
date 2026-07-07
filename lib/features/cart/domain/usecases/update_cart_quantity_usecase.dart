import 'package:equatable/equatable.dart';
import 'package:owlmart/core/usecase/usecase.dart';
import '../repository/cart_repository.dart';

class UpdateCartQuantityUseCase implements UseCase<void, UpdateCartQuantityParams> {
  final CartRepository repository;

  const UpdateCartQuantityUseCase({required this.repository});

  @override
  Future<void> call(UpdateCartQuantityParams params) async {
    return repository.updateQuantity(params.userId, params.productId, params.quantity);
  }
}

class UpdateCartQuantityParams extends Equatable {
  final String userId;
  final String productId;
  final int quantity;

  const UpdateCartQuantityParams({
    required this.userId,
    required this.productId,
    required this.quantity,
  });

  @override
  List<Object?> get props => [userId, productId, quantity];
}
