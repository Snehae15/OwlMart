import '../entities/admin_dashboard_stats.dart';
import '../entities/admin_order_entity.dart';
import '../entities/category_entity.dart';

abstract class AdminRepository {
  // Dashboard
  Future<AdminDashboardStats> getDashboardStats();

  // Category
  Future<List<CategoryEntity>> getCategories();
  Future<void> addCategory(CategoryEntity category);
  Future<void> updateCategory(CategoryEntity category);
  Future<void> deleteCategory(String id);

  // Inventory / Stock
  Future<void> updateStock(String productId, int newStock);
  Future<void> updateSku(String productId, String sku);

  // Orders
  Future<List<AdminOrderEntity>> getOrders();
  Future<void> updateOrderStatus(String orderId, String status);
}
