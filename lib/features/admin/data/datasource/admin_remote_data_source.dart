import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:owlmart/core/error/exceptions.dart';
import '../../../product/data/models/product_model.dart';
import '../models/admin_order_model.dart';
import '../models/category_model.dart';

abstract class AdminRemoteDataSource {
  // Dashboard
  Future<int> getTotalProductsCount();
  Future<int> getActiveProductsCount();
  Future<int> getTotalOrdersCount();
  Future<double> getTotalRevenueSum();
  Future<List<ProductModel>> getLowStockProducts();

  // Category
  Future<List<CategoryModel>> getCategories();
  Future<void> addCategory(CategoryModel category);
  Future<void> updateCategory(CategoryModel category);
  Future<void> deleteCategory(String id);

  // Inventory
  Future<void> updateStock(String productId, int newStock);
  Future<void> updateSku(String productId, String sku);

  // Orders
  Future<List<AdminOrderModel>> getOrders();
  Future<void> updateOrderStatus(String orderId, String status);
}

class AdminRemoteDataSourceImpl implements AdminRemoteDataSource {
  final FirebaseFirestore firestore;

  const AdminRemoteDataSourceImpl({required this.firestore});

  @override
  Future<int> getTotalProductsCount() async {
    try {
      final snapshot = await firestore.collection('products').count().get();
      return snapshot.count ?? 0;
    } on FirebaseException catch (e) {
      throw ServerException(e.message ?? 'Firestore count total products failed.');
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<int> getActiveProductsCount() async {
    try {
      final snapshot = await firestore.collection('products').where('isEnabled', isEqualTo: true).count().get();
      return snapshot.count ?? 0;
    } on FirebaseException catch (e) {
      throw ServerException(e.message ?? 'Firestore count active products failed.');
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<int> getTotalOrdersCount() async {
    try {
      final snapshot = await firestore.collection('orders').count().get();
      return snapshot.count ?? 0;
    } on FirebaseException catch (e) {
      throw ServerException(e.message ?? 'Firestore count orders failed.');
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<double> getTotalRevenueSum() async {
    try {
      final snapshot = await firestore
          .collection('orders')
          .where('status', isNotEqualTo: 'Cancelled')
          .get();

      double sum = 0.0;
      for (final doc in snapshot.docs) {
        final data = doc.data();
        sum += (data['totalPrice'] as num? ?? 0.0).toDouble();
      }
      return sum;
    } on FirebaseException catch (e) {
      throw ServerException(e.message ?? 'Firestore revenue sum query failed.');
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<List<ProductModel>> getLowStockProducts() async {
    try {
      final snapshot = await firestore
          .collection('products')
          .where('stock', isLessThanOrEqualTo: 5)
          .orderBy('stock')
          .get();

      return snapshot.docs.map((doc) => ProductModel.fromFirestore(doc)).toList();
    } on FirebaseException catch (e) {
      throw ServerException(e.message ?? 'Firestore low stock query failed.');
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<List<CategoryModel>> getCategories() async {
    try {
      final snapshot = await firestore.collection('categories').orderBy('name').get();
      return snapshot.docs.map((doc) => CategoryModel.fromFirestore(doc)).toList();
    } on FirebaseException catch (e) {
      throw ServerException(e.message ?? 'Firestore get categories failed.');
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<void> addCategory(CategoryModel category) async {
    try {
      await firestore.collection('categories').add(category.toFirestore());
    } on FirebaseException catch (e) {
      throw ServerException(e.message ?? 'Firestore add category failed.');
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<void> updateCategory(CategoryModel category) async {
    try {
      await firestore.collection('categories').doc(category.id).update(category.toFirestore());
    } on FirebaseException catch (e) {
      throw ServerException(e.message ?? 'Firestore update category failed.');
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<void> deleteCategory(String id) async {
    try {
      await firestore.collection('categories').doc(id).delete();
    } on FirebaseException catch (e) {
      throw ServerException(e.message ?? 'Firestore delete category failed.');
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<void> updateStock(String productId, int newStock) async {
    try {
      await firestore.collection('products').doc(productId).update({'stock': newStock});
    } on FirebaseException catch (e) {
      throw ServerException(e.message ?? 'Firestore update stock failed.');
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<void> updateSku(String productId, String sku) async {
    try {
      await firestore.collection('products').doc(productId).update({'sku': sku});
    } on FirebaseException catch (e) {
      throw ServerException(e.message ?? 'Firestore update sku failed.');
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<List<AdminOrderModel>> getOrders() async {
    try {
      final snapshot = await firestore.collection('orders').orderBy('createdAt', descending: true).get();
      return snapshot.docs.map((doc) => AdminOrderModel.fromFirestore(doc)).toList();
    } on FirebaseException catch (e) {
      throw ServerException(e.message ?? 'Firestore fetch orders failed.');
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<void> updateOrderStatus(String orderId, String status) async {
    try {
      await firestore.collection('orders').doc(orderId).update({'status': status});
    } on FirebaseException catch (e) {
      throw ServerException(e.message ?? 'Firestore update order status failed.');
    } catch (e) {
      throw ServerException(e.toString());
    }
  }
}
