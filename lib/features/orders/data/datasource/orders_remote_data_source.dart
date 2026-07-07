import '../models/orders_model.dart';

abstract class OrdersRemoteDataSource {
  Future<OrdersModel> getOrdersFromApi();
}

class OrdersRemoteDataSourceImpl implements OrdersRemoteDataSource {
  const OrdersRemoteDataSourceImpl();

  @override
  Future<OrdersModel> getOrdersFromApi() async {
    throw UnimplementedError();
  }
}
