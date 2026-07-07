import 'package:owlmart/core/usecase/usecase.dart';
import '../repository/cart_repository.dart';

class ClearCartUseCase implements UseCase<void, String> {
  final CartRepository repository;

  const ClearCartUseCase({required this.repository});

  @override
  Future<void> call(String userId) async {
    return repository.clearCart(userId);
  }
}
