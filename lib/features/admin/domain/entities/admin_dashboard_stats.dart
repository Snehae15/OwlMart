import 'package:equatable/equatable.dart';
import '../../../product/domain/entities/product_entity.dart';

class AdminDashboardStats extends Equatable {
  final int totalProducts;
  final int activeProducts;
  final int totalOrders;
  final double totalRevenue;
  final List<ProductEntity> lowStockProducts;

  const AdminDashboardStats({
    required this.totalProducts,
    required this.activeProducts,
    required this.totalOrders,
    required this.totalRevenue,
    required this.lowStockProducts,
  });

  @override
  List<Object?> get props => [totalProducts, activeProducts, totalOrders, totalRevenue, lowStockProducts];
}
