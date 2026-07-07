import '../entities/orders_entity.dart';

abstract class OrdersRepository {
  Future<OrdersEntity> getOrdersData();
}
