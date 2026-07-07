import 'package:equatable/equatable.dart';
import '../../domain/entities/admin_dashboard_stats.dart';
import '../../domain/entities/admin_order_entity.dart';
import '../../domain/entities/category_entity.dart';

abstract class AdminState extends Equatable {
  const AdminState();

  @override
  List<Object?> get props => [];
}

class AdminInitial extends AdminState {
  const AdminInitial();
}

class AdminLoading extends AdminState {
  const AdminLoading();
}

class AdminDashboardLoaded extends AdminState {
  final AdminDashboardStats stats;

  const AdminDashboardLoaded({required this.stats});

  @override
  List<Object?> get props => [stats];
}

class AdminCategoriesLoaded extends AdminState {
  final List<CategoryEntity> categories;

  const AdminCategoriesLoaded({required this.categories});

  @override
  List<Object?> get props => [categories];
}

class AdminOrdersLoaded extends AdminState {
  final List<AdminOrderEntity> orders;

  const AdminOrdersLoaded({required this.orders});

  @override
  List<Object?> get props => [orders];
}

class AdminOperationSuccess extends AdminState {
  final String message;

  const AdminOperationSuccess({required this.message});

  @override
  List<Object?> get props => [message];
}

class AdminError extends AdminState {
  final String message;

  const AdminError({required this.message});

  @override
  List<Object?> get props => [message];
}
