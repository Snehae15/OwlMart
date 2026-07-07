import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:owlmart/core/error/exceptions.dart';
import '../models/cart_item_model.dart';

abstract class CartRemoteDataSource {
  Future<List<CartItemModel>> getCart(String userId);
  Future<void> addToCart(String userId, CartItemModel item);
  Future<void> removeFromCart(String userId, String productId);
  Future<void> updateQuantity(String userId, String productId, int quantity);
  Future<void> clearCart(String userId);
}

class CartRemoteDataSourceImpl implements CartRemoteDataSource {
  final FirebaseFirestore firestore;

  const CartRemoteDataSourceImpl({required this.firestore});

  CollectionReference _cartCollection(String userId) {
    return firestore.collection('users').doc(userId).collection('cart');
  }

  @override
  Future<List<CartItemModel>> getCart(String userId) async {
    try {
      final snapshot = await _cartCollection(userId).get();
      return snapshot.docs.map((doc) => CartItemModel.fromFirestore(doc)).toList();
    } on FirebaseException catch (e) {
      throw ServerException(e.message ?? 'Firestore fetch cart failed.');
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<void> addToCart(String userId, CartItemModel item) async {
    try {
      final docRef = _cartCollection(userId).doc(item.productId);
      final doc = await docRef.get();
      if (doc.exists) {
        final currentQty = (doc.data() as Map<String, dynamic>?)?['quantity'] as int? ?? 0;
        await docRef.update({'quantity': currentQty + item.quantity});
      } else {
        await docRef.set(item.toFirestore());
      }
    } on FirebaseException catch (e) {
      throw ServerException(e.message ?? 'Firestore add to cart failed.');
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<void> removeFromCart(String userId, String productId) async {
    try {
      await _cartCollection(userId).doc(productId).delete();
    } on FirebaseException catch (e) {
      throw ServerException(e.message ?? 'Firestore remove from cart failed.');
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<void> updateQuantity(String userId, String productId, int quantity) async {
    try {
      if (quantity <= 0) {
        await removeFromCart(userId, productId);
      } else {
        await _cartCollection(userId).doc(productId).update({'quantity': quantity});
      }
    } on FirebaseException catch (e) {
      throw ServerException(e.message ?? 'Firestore update quantity failed.');
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<void> clearCart(String userId) async {
    try {
      final batch = firestore.batch();
      final snapshot = await _cartCollection(userId).get();
      for (final doc in snapshot.docs) {
        batch.delete(doc.reference);
      }
      await batch.commit();
    } on FirebaseException catch (e) {
      throw ServerException(e.message ?? 'Firestore clear cart failed.');
    } catch (e) {
      throw ServerException(e.toString());
    }
  }
}
