import 'package:owlmart/core/error/exceptions.dart';
import 'package:owlmart/core/error/failures.dart';
import 'package:owlmart/core/network/network_info.dart';
import '../../domain/entities/wishlist_item_entity.dart';
import '../../domain/repository/wishlist_repository.dart';
import '../datasource/wishlist_remote_data_source.dart';
import '../models/wishlist_item_model.dart';

class WishlistRepositoryImpl implements WishlistRepository {
  final WishlistRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  const WishlistRepositoryImpl({
    required this.remoteDataSource,
    required this.networkInfo,
  });

  @override
  Future<List<WishlistItemEntity>> getWishlist(String userId) async {
    if (await networkInfo.isConnected) {
      try {
        final wishlistItems = await remoteDataSource.getWishlist(userId);
        return wishlistItems;
      } on ServerException catch (e) {
        throw ServerFailure(e.message ?? 'Failed to load wishlist items');
      }
    } else {
      throw const NetworkFailure('No internet connection');
    }
  }

  @override
  Future<void> addToWishlist(String userId, WishlistItemEntity item) async {
    if (await networkInfo.isConnected) {
      try {
        final model = WishlistItemModel.fromEntity(item);
        await remoteDataSource.addToWishlist(userId, model);
      } on ServerException catch (e) {
        throw ServerFailure(e.message ?? 'Failed to add item to wishlist');
      }
    } else {
      throw const NetworkFailure('No internet connection');
    }
  }

  @override
  Future<void> removeFromWishlist(String userId, String productId) async {
    if (await networkInfo.isConnected) {
      try {
        await remoteDataSource.removeFromWishlist(userId, productId);
      } on ServerException catch (e) {
        throw ServerFailure(e.message ?? 'Failed to remove item from wishlist');
      }
    } else {
      throw const NetworkFailure('No internet connection');
    }
  }

  @override
  Future<bool> isWishlisted(String userId, String productId) async {
    if (await networkInfo.isConnected) {
      try {
        final wishlisted = await remoteDataSource.isWishlisted(userId, productId);
        return wishlisted;
      } on ServerException catch (e) {
        throw ServerFailure(e.message ?? 'Failed to check wishlist status');
      }
    } else {
      throw const NetworkFailure('No internet connection');
    }
  }
}
