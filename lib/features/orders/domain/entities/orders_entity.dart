import 'package:equatable/equatable.dart';

class OrdersEntity extends Equatable {
  final String id;

  const OrdersEntity({required this.id});

  @override
  List<Object?> get props => [id];
}
