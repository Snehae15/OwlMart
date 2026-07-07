import 'package:equatable/equatable.dart';
import 'package:owlmart/core/usecase/usecase.dart';
import '../repository/cart_repository.dart';

class RemoveFromCartUseCase implements UseCase<void, RemoveFromCartParams> {
  final CartRepository repository;

  const RemoveFromCartUseCase({required this.repository});

  @override
  Future<void> call(RemoveFromCartParams params) async {
    return repository.removeFromCart(params.userId, params.productId);
  }
}

class RemoveFromCartParams extends Equatable {
  final String userId;
  final String productId;

  const RemoveFromCartParams({required this.userId, required this.productId});

  @override
  List<Object?> get props => [userId, productId];
}
