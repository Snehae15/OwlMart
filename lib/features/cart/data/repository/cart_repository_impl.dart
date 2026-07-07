import 'package:owlmart/core/error/exceptions.dart';
import 'package:owlmart/core/error/failures.dart';
import 'package:owlmart/core/network/network_info.dart';
import '../../domain/entities/cart_item_entity.dart';
import '../../domain/repository/cart_repository.dart';
import '../datasource/cart_remote_data_source.dart';
import '../models/cart_item_model.dart';

class CartRepositoryImpl implements CartRepository {
  final CartRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  const CartRepositoryImpl({
    required this.remoteDataSource,
    required this.networkInfo,
  });

  @override
  Future<List<CartItemEntity>> getCart(String userId) async {
    if (await networkInfo.isConnected) {
      try {
        final cartItems = await remoteDataSource.getCart(userId);
        return cartItems;
      } on ServerException catch (e) {
        throw ServerFailure(e.message ?? 'Failed to load cart items');
      }
    } else {
      throw const NetworkFailure('No internet connection');
    }
  }

  @override
  Future<void> addToCart(String userId, CartItemEntity item) async {
    if (await networkInfo.isConnected) {
      try {
        final model = CartItemModel.fromEntity(item);
        await remoteDataSource.addToCart(userId, model);
      } on ServerException catch (e) {
        throw ServerFailure(e.message ?? 'Failed to add item to cart');
      }
    } else {
      throw const NetworkFailure('No internet connection');
    }
  }

  @override
  Future<void> removeFromCart(String userId, String productId) async {
    if (await networkInfo.isConnected) {
      try {
        await remoteDataSource.removeFromCart(userId, productId);
      } on ServerException catch (e) {
        throw ServerFailure(e.message ?? 'Failed to remove item from cart');
      }
    } else {
      throw const NetworkFailure('No internet connection');
    }
  }

  @override
  Future<void> updateQuantity(String userId, String productId, int quantity) async {
    if (await networkInfo.isConnected) {
      try {
        await remoteDataSource.updateQuantity(userId, productId, quantity);
      } on ServerException catch (e) {
        throw ServerFailure(e.message ?? 'Failed to update item quantity');
      }
    } else {
      throw const NetworkFailure('No internet connection');
    }
  }

  @override
  Future<void> clearCart(String userId) async {
    if (await networkInfo.isConnected) {
      try {
        await remoteDataSource.clearCart(userId);
      } on ServerException catch (e) {
        throw ServerFailure(e.message ?? 'Failed to clear cart');
      }
    } else {
      throw const NetworkFailure('No internet connection');
    }
  }
}
