import 'package:cloud_firestore/cloud_firestore.dart';
import '../../domain/entities/admin_order_entity.dart';

class AdminOrderModel extends AdminOrderEntity {
  const AdminOrderModel({
    required super.id,
    required super.userId,
    required super.itemNames,
    required super.totalPrice,
    required super.status,
    required super.createdAt,
  });

  factory AdminOrderModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>? ?? {};
    final list = data['itemNames'] as List<dynamic>? ?? [];
    return AdminOrderModel(
      id: doc.id,
      userId: data['userId'] as String? ?? '',
      itemNames: list.map((e) => e.toString()).toList(),
      totalPrice: (data['totalPrice'] as num? ?? 0.0).toDouble(),
      status: data['status'] as String? ?? 'Pending',
      createdAt: data['createdAt'] != null
          ? (data['createdAt'] as Timestamp).toDate()
          : DateTime.now(),
    );
  }

  factory AdminOrderModel.fromEntity(AdminOrderEntity entity) {
    return AdminOrderModel(
      id: entity.id,
      userId: entity.userId,
      itemNames: entity.itemNames,
      totalPrice: entity.totalPrice,
      status: entity.status,
      createdAt: entity.createdAt,
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'userId': userId,
      'itemNames': itemNames,
      'totalPrice': totalPrice,
      'status': status,
      'createdAt': Timestamp.fromDate(createdAt),
    };
  }
}
