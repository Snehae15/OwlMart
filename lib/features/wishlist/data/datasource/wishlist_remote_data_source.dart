import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:owlmart/core/error/exceptions.dart';
import '../models/wishlist_item_model.dart';

abstract class WishlistRemoteDataSource {
  Future<List<WishlistItemModel>> getWishlist(String userId);
  Future<void> addToWishlist(String userId, WishlistItemModel item);
  Future<void> removeFromWishlist(String userId, String productId);
  Future<bool> isWishlisted(String userId, String productId);
}

class WishlistRemoteDataSourceImpl implements WishlistRemoteDataSource {
  final FirebaseFirestore firestore;

  const WishlistRemoteDataSourceImpl({required this.firestore});

  CollectionReference _wishlistCollection(String userId) {
    return firestore.collection('users').doc(userId).collection('wishlist');
  }

  @override
  Future<List<WishlistItemModel>> getWishlist(String userId) async {
    try {
      final snapshot = await _wishlistCollection(userId).orderBy('addedAt', descending: true).get();
      return snapshot.docs.map((doc) => WishlistItemModel.fromFirestore(doc)).toList();
    } on FirebaseException catch (e) {
      throw ServerException(e.message ?? 'Firestore fetch wishlist failed.');
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<void> addToWishlist(String userId, WishlistItemModel item) async {
    try {
      await _wishlistCollection(userId).doc(item.productId).set(item.toFirestore());
    } on FirebaseException catch (e) {
      throw ServerException(e.message ?? 'Firestore add to wishlist failed.');
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<void> removeFromWishlist(String userId, String productId) async {
    try {
      await _wishlistCollection(userId).doc(productId).delete();
    } on FirebaseException catch (e) {
      throw ServerException(e.message ?? 'Firestore remove from wishlist failed.');
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<bool> isWishlisted(String userId, String productId) async {
    try {
      final doc = await _wishlistCollection(userId).doc(productId).get();
      return doc.exists;
    } on FirebaseException catch (e) {
      throw ServerException(e.message ?? 'Firestore check wishlist status failed.');
    } catch (e) {
      throw ServerException(e.toString());
    }
  }
}
