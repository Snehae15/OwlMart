import 'package:owlmart/core/usecase/usecase.dart';
import '../entities/orders_entity.dart';
import '../repository/orders_repository.dart';

class GetOrdersUseCase implements UseCase<OrdersEntity, NoParams> {
  final OrdersRepository repository;

  const GetOrdersUseCase({required this.repository});

  @override
  Future<OrdersEntity> call(NoParams params) async {
    return repository.getOrdersData();
  }
}
