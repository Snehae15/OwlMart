import '../../domain/entities/orders_entity.dart';

class OrdersModel extends OrdersEntity {
  const OrdersModel({required super.id});

  factory OrdersModel.fromJson(Map<String, dynamic> json) {
    return OrdersModel(
      id: json['id'] as String? ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
    };
  }
}
