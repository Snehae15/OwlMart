import 'package:owlmart/core/usecase/usecase.dart';
import '../entities/cart_entity.dart';
import '../repository/cart_repository.dart';

class GetCartUseCase implements UseCase<CartEntity, NoParams> {
  final CartRepository repository;

  const GetCartUseCase({required this.repository});

  @override
  Future<CartEntity> call(NoParams params) async {
    return repository.getCartData();
  }
}
