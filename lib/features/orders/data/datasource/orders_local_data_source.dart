import '../models/orders_model.dart';

abstract class OrdersLocalDataSource {
  Future<OrdersModel> getLastOrders();
  Future<void> cacheOrders(OrdersModel modelToCache);
}

class OrdersLocalDataSourceImpl implements OrdersLocalDataSource {
  const OrdersLocalDataSourceImpl();

  @override
  Future<OrdersModel> getLastOrders() async {
    throw UnimplementedError();
  }

  @override
  Future<void> cacheOrders(OrdersModel modelToCache) async {
    throw UnimplementedError();
  }
}
