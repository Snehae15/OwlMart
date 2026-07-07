import 'package:owlmart/core/error/exceptions.dart';
import 'package:owlmart/core/error/failures.dart';
import 'package:owlmart/core/network/network_info.dart';
import '../../domain/entities/admin_dashboard_stats.dart';
import '../../domain/entities/admin_order_entity.dart';
import '../../domain/entities/category_entity.dart';
import '../../domain/repository/admin_repository.dart';
import '../datasource/admin_remote_data_source.dart';
import '../models/category_model.dart';

class AdminRepositoryImpl implements AdminRepository {
  final AdminRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  const AdminRepositoryImpl({
    required this.remoteDataSource,
    required this.networkInfo,
  });

  @override
  Future<AdminDashboardStats> getDashboardStats() async {
    if (await networkInfo.isConnected) {
      try {
        final totalProducts = await remoteDataSource.getTotalProductsCount();
        final activeProducts = await remoteDataSource.getActiveProductsCount();
        final totalOrders = await remoteDataSource.getTotalOrdersCount();
        final totalRevenue = await remoteDataSource.getTotalRevenueSum();
        final lowStockProducts = await remoteDataSource.getLowStockProducts();

        return AdminDashboardStats(
          totalProducts: totalProducts,
          activeProducts: activeProducts,
          totalOrders: totalOrders,
          totalRevenue: totalRevenue,
          lowStockProducts: lowStockProducts,
        );
      } on ServerException catch (e) {
        throw ServerFailure(e.message ?? 'Failed to compute dashboard stats');
      }
    } else {
      throw const NetworkFailure('No internet connection');
    }
  }

  @override
  Future<List<CategoryEntity>> getCategories() async {
    if (await networkInfo.isConnected) {
      try {
        final categories = await remoteDataSource.getCategories();
        return categories;
      } on ServerException catch (e) {
        throw ServerFailure(e.message ?? 'Failed to load categories');
      }
    } else {
      throw const NetworkFailure('No internet connection');
    }
  }

  @override
  Future<void> addCategory(CategoryEntity category) async {
    if (await networkInfo.isConnected) {
      try {
        final model = CategoryModel.fromEntity(category);
        await remoteDataSource.addCategory(model);
      } on ServerException catch (e) {
        throw ServerFailure(e.message ?? 'Failed to add category');
      }
    } else {
      throw const NetworkFailure('No internet connection');
    }
  }

  @override
  Future<void> updateCategory(CategoryEntity category) async {
    if (await networkInfo.isConnected) {
      try {
        final model = CategoryModel.fromEntity(category);
        await remoteDataSource.updateCategory(model);
      } on ServerException catch (e) {
        throw ServerFailure(e.message ?? 'Failed to update category');
      }
    } else {
      throw const NetworkFailure('No internet connection');
    }
  }

  @override
  Future<void> deleteCategory(String id) async {
    if (await networkInfo.isConnected) {
      try {
        await remoteDataSource.deleteCategory(id);
      } on ServerException catch (e) {
        throw ServerFailure(e.message ?? 'Failed to delete category');
      }
    } else {
      throw const NetworkFailure('No internet connection');
    }
  }

  @override
  Future<void> updateStock(String productId, int newStock) async {
    if (await networkInfo.isConnected) {
      try {
        await remoteDataSource.updateStock(productId, newStock);
      } on ServerException catch (e) {
        throw ServerFailure(e.message ?? 'Failed to update product stock');
      }
    } else {
      throw const NetworkFailure('No internet connection');
    }
  }

  @override
  Future<void> updateSku(String productId, String sku) async {
    if (await networkInfo.isConnected) {
      try {
        await remoteDataSource.updateSku(productId, sku);
      } on ServerException catch (e) {
        throw ServerFailure(e.message ?? 'Failed to update product SKU');
      }
    } else {
      throw const NetworkFailure('No internet connection');
    }
  }

  @override
  Future<List<AdminOrderEntity>> getOrders() async {
    if (await networkInfo.isConnected) {
      try {
        final orders = await remoteDataSource.getOrders();
        return orders;
      } on ServerException catch (e) {
        throw ServerFailure(e.message ?? 'Failed to load order listings');
      }
    } else {
      throw const NetworkFailure('No internet connection');
    }
  }

  @override
  Future<void> updateOrderStatus(String orderId, String status) async {
    if (await networkInfo.isConnected) {
      try {
        await remoteDataSource.updateOrderStatus(orderId, status);
      } on ServerException catch (e) {
        throw ServerFailure(e.message ?? 'Failed to update order status');
      }
    } else {
      throw const NetworkFailure('No internet connection');
    }
  }
}
