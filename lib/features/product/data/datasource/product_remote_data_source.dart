import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:owlmart/core/error/exceptions.dart';
import '../models/product_model.dart';

abstract class ProductRemoteDataSource {
  Future<List<ProductModel>> getProducts({String? category, bool? onlyEnabled});
  Future<ProductModel> getProductById(String id);
  Future<void> addProduct(ProductModel product);
  Future<void> updateProduct(ProductModel product);
  Future<void> deleteProduct(String id);
  Future<void> toggleProductStatus(String id, bool isEnabled);
  Future<List<ProductModel>> searchProducts(String query);
}

class ProductRemoteDataSourceImpl implements ProductRemoteDataSource {
  final FirebaseFirestore firestore;

  const ProductRemoteDataSourceImpl({required this.firestore});

  @override
  Future<List<ProductModel>> getProducts({String? category, bool? onlyEnabled}) async {
    try {
      Query query = firestore.collection('products');

      if (category != null && category.isNotEmpty) {
        query = query.where('category', isEqualTo: category);
      }

      if (onlyEnabled != null) {
        query = query.where('isEnabled', isEqualTo: onlyEnabled);
      }

      // Order by creation time to show newer products first
      query = query.orderBy('createdAt', descending: true);

      final snapshot = await query.get();
      return snapshot.docs.map((doc) => ProductModel.fromFirestore(doc)).toList();
    } on FirebaseException catch (e) {
      throw ServerException(e.message ?? 'Firestore query failed.');
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<ProductModel> getProductById(String id) async {
    try {
      final doc = await firestore.collection('products').doc(id).get();
      if (doc.exists) {
        return ProductModel.fromFirestore(doc);
      } else {
        throw const ServerException('Product not found.');
      }
    } on FirebaseException catch (e) {
      throw ServerException(e.message ?? 'Firestore fetch failed.');
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<void> addProduct(ProductModel product) async {
    try {
      if (product.id.isNotEmpty) {
        await firestore.collection('products').doc(product.id).set(product.toFirestore());
      } else {
        await firestore.collection('products').add(product.toFirestore());
      }
    } on FirebaseException catch (e) {
      throw ServerException(e.message ?? 'Firestore write failed.');
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<void> updateProduct(ProductModel product) async {
    try {
      await firestore.collection('products').doc(product.id).update(product.toFirestore());
    } on FirebaseException catch (e) {
      throw ServerException(e.message ?? 'Firestore update failed.');
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<void> deleteProduct(String id) async {
    try {
      await firestore.collection('products').doc(id).delete();
    } on FirebaseException catch (e) {
      throw ServerException(e.message ?? 'Firestore delete failed.');
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<void> toggleProductStatus(String id, bool isEnabled) async {
    try {
      await firestore.collection('products').doc(id).update({'isEnabled': isEnabled});
    } on FirebaseException catch (e) {
      throw ServerException(e.message ?? 'Firestore update status failed.');
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<List<ProductModel>> searchProducts(String queryText) async {
    try {
      if (queryText.isEmpty) {
        return [];
      }
      
      // Native optimized prefix range query
      final snapshot = await firestore
          .collection('products')
          .where('name', isGreaterThanOrEqualTo: queryText)
          .where('name', isLessThanOrEqualTo: '$queryText\uf8ff')
          .get();

      return snapshot.docs.map((doc) => ProductModel.fromFirestore(doc)).toList();
    } on FirebaseException catch (e) {
      throw ServerException(e.message ?? 'Firestore search failed.');
    } catch (e) {
      throw ServerException(e.toString());
    }
  }
}
