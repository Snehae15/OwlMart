import 'package:equatable/equatable.dart';

class AdminOrderEntity extends Equatable {
  final String id;
  final String userId;
  final List<String> itemNames;
  final double totalPrice;
  final String status;
  final DateTime createdAt;

  const AdminOrderEntity({
    required this.id,
    required this.userId,
    required this.itemNames,
    required this.totalPrice,
    required this.status,
    required this.createdAt,
  });

  @override
  List<Object?> get props => [id, userId, itemNames, totalPrice, status, createdAt];
}
