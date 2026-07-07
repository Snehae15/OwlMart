import 'package:equatable/equatable.dart';
import 'package:owlmart/core/usecase/usecase.dart';
import '../entities/cart_item_entity.dart';
import '../repository/cart_repository.dart';

class AddToCartUseCase implements UseCase<void, AddToCartParams> {
  final CartRepository repository;

  const AddToCartUseCase({required this.repository});

  @override
  Future<void> call(AddToCartParams params) async {
    return repository.addToCart(params.userId, params.item);
  }
}

class AddToCartParams extends Equatable {
  final String userId;
  final CartItemEntity item;

  const AddToCartParams({required this.userId, required this.item});

  @override
  List<Object?> get props => [userId, item];
}
