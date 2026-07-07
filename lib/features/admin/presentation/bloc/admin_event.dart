import 'package:equatable/equatable.dart';
import '../../domain/entities/category_entity.dart';

abstract class AdminEvent extends Equatable {
  const AdminEvent();

  @override
  List<Object?> get props => [];
}

class LoadAdminDashboardEvent extends AdminEvent {
  const LoadAdminDashboardEvent();
}

class LoadAdminCategoriesEvent extends AdminEvent {
  const LoadAdminCategoriesEvent();
}

class AddCategoryEvent extends AdminEvent {
  final CategoryEntity category;

  const AddCategoryEvent({required this.category});

  @override
  List<Object?> get props => [category];
}

class DeleteCategoryEvent extends AdminEvent {
  final String id;

  const DeleteCategoryEvent({required this.id});

  @override
  List<Object?> get props => [id];
}

class UpdateStockEvent extends AdminEvent {
  final String productId;
  final int newStock;

  const UpdateStockEvent({required this.productId, required this.newStock});

  @override
  List<Object?> get props => [productId, newStock];
}

class UpdateSkuEvent extends AdminEvent {
  final String productId;
  final String sku;

  const UpdateSkuEvent({required this.productId, required this.sku});

  @override
  List<Object?> get props => [productId, sku];
}

class LoadAdminOrdersEvent extends AdminEvent {
  const LoadAdminOrdersEvent();
}

class UpdateOrderStatusEvent extends AdminEvent {
  final String orderId;
  final String status;

  const UpdateOrderStatusEvent({required this.orderId, required this.status});

  @override
  List<Object?> get props => [orderId, status];
}
