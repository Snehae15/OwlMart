import 'package:owlmart/core/network/network_info.dart';
import '../../domain/entities/wishlist_entity.dart';
import '../../domain/repository/wishlist_repository.dart';
import '../datasource/wishlist_local_data_source.dart';
import '../datasource/wishlist_remote_data_source.dart';

class WishlistRepositoryImpl implements WishlistRepository {
  final WishlistRemoteDataSource remoteDataSource;
  final WishlistLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  const WishlistRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.networkInfo,
  });

  @override
  Future<WishlistEntity> getWishlistData() async {
    if (await networkInfo.isConnected) {
      final remoteData = await remoteDataSource.getWishlistFromApi();
      await localDataSource.cacheWishlist(remoteData);
      return remoteData;
    } else {
      return localDataSource.getLastWishlist();
    }
  }
}
