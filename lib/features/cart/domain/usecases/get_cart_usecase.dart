import 'package:owlmart/core/usecase/usecase.dart';
import '../entities/cart_item_entity.dart';
import '../repository/cart_repository.dart';

class GetCartUseCase implements UseCase<List<CartItemEntity>, String> {
  final CartRepository repository;

  const GetCartUseCase({required this.repository});

  @override
  Future<List<CartItemEntity>> call(String userId) async {
    return repository.getCart(userId);
  }
}
