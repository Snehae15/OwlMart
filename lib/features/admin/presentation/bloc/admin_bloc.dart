import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:owlmart/core/usecase/usecase.dart';
import '../../domain/usecases/add_category_usecase.dart';
import '../../domain/usecases/delete_category_usecase.dart';
import '../../domain/usecases/get_admin_dashboard_stats_usecase.dart';
import '../../domain/usecases/get_admin_orders_usecase.dart';
import '../../domain/usecases/get_categories_usecase.dart';
import '../../domain/usecases/update_order_status_usecase.dart';
import '../../domain/usecases/update_product_sku_usecase.dart';
import '../../domain/usecases/update_product_stock_usecase.dart';
import 'admin_event.dart';
import 'admin_state.dart';

class AdminBloc extends Bloc<AdminEvent, AdminState> {
  final GetAdminDashboardStatsUseCase getDashboardStatsUseCase;
  final GetCategoriesUseCase getCategoriesUseCase;
  final AddCategoryUseCase addCategoryUseCase;
  final DeleteCategoryUseCase deleteCategoryUseCase;
  final UpdateProductStockUseCase updateStockUseCase;
  final UpdateProductSkuUseCase updateSkuUseCase;
  final GetAdminOrdersUseCase getOrdersUseCase;
  final UpdateOrderStatusUseCase updateOrderStatusUseCase;

  AdminBloc({
    required this.getDashboardStatsUseCase,
    required this.getCategoriesUseCase,
    required this.addCategoryUseCase,
    required this.deleteCategoryUseCase,
    required this.updateStockUseCase,
    required this.updateSkuUseCase,
    required this.getOrdersUseCase,
    required this.updateOrderStatusUseCase,
  }) : super(const AdminInitial()) {
    on<LoadAdminDashboardEvent>(_onLoadDashboard);
    on<LoadAdminCategoriesEvent>(_onLoadCategories);
    on<AddCategoryEvent>(_onAddCategory);
    on<DeleteCategoryEvent>(_onDeleteCategory);
    on<UpdateStockEvent>(_onUpdateStock);
    on<UpdateSkuEvent>(_onUpdateSku);
    on<LoadAdminOrdersEvent>(_onLoadOrders);
    on<UpdateOrderStatusEvent>(_onUpdateOrderStatus);
  }

  Future<void> _onLoadDashboard(LoadAdminDashboardEvent event, Emitter<AdminState> emit) async {
    emit(const AdminLoading());
    try {
      final stats = await getDashboardStatsUseCase(const NoParams());
      emit(AdminDashboardLoaded(stats: stats));
    } catch (e) {
      emit(AdminError(message: e.toString()));
    }
  }

  Future<void> _onLoadCategories(LoadAdminCategoriesEvent event, Emitter<AdminState> emit) async {
    emit(const AdminLoading());
    try {
      final categories = await getCategoriesUseCase(const NoParams());
      emit(AdminCategoriesLoaded(categories: categories));
    } catch (e) {
      emit(AdminError(message: e.toString()));
    }
  }

  Future<void> _onAddCategory(AddCategoryEvent event, Emitter<AdminState> emit) async {
    emit(const AdminLoading());
    try {
      await addCategoryUseCase(event.category);
      emit(const AdminOperationSuccess(message: 'Category added successfully'));
    } catch (e) {
      emit(AdminError(message: e.toString()));
    }
  }

  Future<void> _onDeleteCategory(DeleteCategoryEvent event, Emitter<AdminState> emit) async {
    emit(const AdminLoading());
    try {
      await deleteCategoryUseCase(event.id);
      emit(const AdminOperationSuccess(message: 'Category deleted successfully'));
    } catch (e) {
      emit(AdminError(message: e.toString()));
    }
  }

  Future<void> _onUpdateStock(UpdateStockEvent event, Emitter<AdminState> emit) async {
    emit(const AdminLoading());
    try {
      await updateStockUseCase(
        UpdateProductStockParams(productId: event.productId, newStock: event.newStock),
      );
      emit(const AdminOperationSuccess(message: 'Stock updated successfully'));
    } catch (e) {
      emit(AdminError(message: e.toString()));
    }
  }

  Future<void> _onUpdateSku(UpdateSkuEvent event, Emitter<AdminState> emit) async {
    emit(const AdminLoading());
    try {
      await updateSkuUseCase(
        UpdateProductSkuParams(productId: event.productId, sku: event.sku),
      );
      emit(const AdminOperationSuccess(message: 'Product SKU updated successfully'));
    } catch (e) {
      emit(AdminError(message: e.toString()));
    }
  }

  Future<void> _onLoadOrders(LoadAdminOrdersEvent event, Emitter<AdminState> emit) async {
    emit(const AdminLoading());
    try {
      final orders = await getOrdersUseCase(const NoParams());
      emit(AdminOrdersLoaded(orders: orders));
    } catch (e) {
      emit(AdminError(message: e.toString()));
    }
  }

  Future<void> _onUpdateOrderStatus(UpdateOrderStatusEvent event, Emitter<AdminState> emit) async {
    emit(const AdminLoading());
    try {
      await updateOrderStatusUseCase(
        UpdateOrderStatusParams(orderId: event.orderId, status: event.status),
      );
      emit(AdminOperationSuccess(message: 'Order status updated to ${event.status}'));
    } catch (e) {
      emit(AdminError(message: e.toString()));
    }
  }
}
