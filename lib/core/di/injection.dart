import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:owlmart/core/network/network_info.dart';

import 'package:google_sign_in/google_sign_in.dart';

// Authentication Feature
import 'package:owlmart/features/authentication/data/datasource/authentication_local_data_source.dart';
import 'package:owlmart/features/authentication/data/datasource/authentication_remote_data_source.dart';
import 'package:owlmart/features/authentication/data/repository/authentication_repository_impl.dart';
import 'package:owlmart/features/authentication/domain/repository/authentication_repository.dart';
import 'package:owlmart/features/authentication/domain/usecases/get_current_user_usecase.dart';
import 'package:owlmart/features/authentication/domain/usecases/login_with_email_usecase.dart';
import 'package:owlmart/features/authentication/domain/usecases/login_with_google_usecase.dart';
import 'package:owlmart/features/authentication/domain/usecases/logout_usecase.dart';
import 'package:owlmart/features/authentication/presentation/bloc/authentication_bloc.dart';

// Home Feature
import 'package:owlmart/features/home/data/datasource/home_local_data_source.dart';
import 'package:owlmart/features/home/data/datasource/home_remote_data_source.dart';
import 'package:owlmart/features/home/data/repository/home_repository_impl.dart';
import 'package:owlmart/features/home/domain/repository/home_repository.dart';
import 'package:owlmart/features/home/domain/usecases/get_home_usecase.dart';
import 'package:owlmart/features/home/presentation/bloc/home_bloc.dart';

// Product Feature
import 'package:owlmart/features/product/data/datasource/product_local_data_source.dart';
import 'package:owlmart/features/product/data/datasource/product_remote_data_source.dart';
import 'package:owlmart/features/product/data/repository/product_repository_impl.dart';
import 'package:owlmart/features/product/domain/repository/product_repository.dart';
import 'package:owlmart/features/product/domain/usecases/add_product_usecase.dart';
import 'package:owlmart/features/product/domain/usecases/delete_product_usecase.dart';
import 'package:owlmart/features/product/domain/usecases/get_product_details_usecase.dart';
import 'package:owlmart/features/product/domain/usecases/get_products_usecase.dart';
import 'package:owlmart/features/product/domain/usecases/search_products_usecase.dart';
import 'package:owlmart/features/product/domain/usecases/toggle_product_status_usecase.dart';
import 'package:owlmart/features/product/domain/usecases/update_product_usecase.dart';
import 'package:owlmart/features/product/presentation/bloc/product_bloc.dart';

// Category Feature
import 'package:owlmart/features/category/data/datasource/category_local_data_source.dart';
import 'package:owlmart/features/category/data/datasource/category_remote_data_source.dart';
import 'package:owlmart/features/category/data/repository/category_repository_impl.dart';
import 'package:owlmart/features/category/domain/repository/category_repository.dart';
import 'package:owlmart/features/category/domain/usecases/get_category_usecase.dart';
import 'package:owlmart/features/category/presentation/bloc/category_bloc.dart';

// Cart Feature
import 'package:owlmart/features/cart/data/datasource/cart_local_data_source.dart';
import 'package:owlmart/features/cart/data/datasource/cart_remote_data_source.dart';
import 'package:owlmart/features/cart/data/repository/cart_repository_impl.dart';
import 'package:owlmart/features/cart/domain/repository/cart_repository.dart';
import 'package:owlmart/features/cart/domain/usecases/get_cart_usecase.dart';
import 'package:owlmart/features/cart/presentation/bloc/cart_bloc.dart';

// Wishlist Feature
import 'package:owlmart/features/wishlist/data/datasource/wishlist_local_data_source.dart';
import 'package:owlmart/features/wishlist/data/datasource/wishlist_remote_data_source.dart';
import 'package:owlmart/features/wishlist/data/repository/wishlist_repository_impl.dart';
import 'package:owlmart/features/wishlist/domain/repository/wishlist_repository.dart';
import 'package:owlmart/features/wishlist/domain/usecases/get_wishlist_usecase.dart';
import 'package:owlmart/features/wishlist/presentation/bloc/wishlist_bloc.dart';

// Search Feature
import 'package:owlmart/features/search/data/datasource/search_local_data_source.dart';
import 'package:owlmart/features/search/data/datasource/search_remote_data_source.dart';
import 'package:owlmart/features/search/data/repository/search_repository_impl.dart';
import 'package:owlmart/features/search/domain/repository/search_repository.dart';
import 'package:owlmart/features/search/domain/usecases/get_search_usecase.dart';
import 'package:owlmart/features/search/presentation/bloc/search_bloc.dart';

// Orders Feature
import 'package:owlmart/features/orders/data/datasource/orders_local_data_source.dart';
import 'package:owlmart/features/orders/data/datasource/orders_remote_data_source.dart';
import 'package:owlmart/features/orders/data/repository/orders_repository_impl.dart';
import 'package:owlmart/features/orders/domain/repository/orders_repository.dart';
import 'package:owlmart/features/orders/domain/usecases/get_orders_usecase.dart';
import 'package:owlmart/features/orders/presentation/bloc/orders_bloc.dart';

// Admin Feature
import 'package:owlmart/features/admin/data/datasource/admin_local_data_source.dart';
import 'package:owlmart/features/admin/data/datasource/admin_remote_data_source.dart';
import 'package:owlmart/features/admin/data/repository/admin_repository_impl.dart';
import 'package:owlmart/features/admin/domain/repository/admin_repository.dart';
import 'package:owlmart/features/admin/domain/usecases/get_admin_usecase.dart';
import 'package:owlmart/features/admin/presentation/bloc/admin_bloc.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // =========================================================================
  // External Dependencies
  // =========================================================================
  sl.registerLazySingleton<FirebaseAuth>(() => FirebaseAuth.instance);
  sl.registerLazySingleton<FirebaseFirestore>(() => FirebaseFirestore.instance);
  sl.registerLazySingleton<FirebaseStorage>(() => FirebaseStorage.instance);
  sl.registerLazySingleton<GoogleSignIn>(() => GoogleSignIn());

  // =========================================================================
  // Core
  // =========================================================================
  sl.registerLazySingleton<NetworkInfo>(() => const NetworkInfoImpl());

  // =========================================================================
  // Features
  // =========================================================================

  // 1. Authentication
  sl.registerFactory(
    () => AuthenticationBloc(
      getCurrentUserUseCase: sl(),
      loginWithEmailUseCase: sl(),
      loginWithGoogleUseCase: sl(),
      logoutUseCase: sl(),
    ),
  );
  sl.registerLazySingleton(() => GetCurrentUserUseCase(repository: sl()));
  sl.registerLazySingleton(() => LoginWithEmailUseCase(repository: sl()));
  sl.registerLazySingleton(() => LoginWithGoogleUseCase(repository: sl()));
  sl.registerLazySingleton(() => LogoutUseCase(repository: sl()));
  sl.registerLazySingleton<AuthenticationRepository>(
    () => AuthenticationRepositoryImpl(
      remoteDataSource: sl(),
      networkInfo: sl(),
    ),
  );
  sl.registerLazySingleton<AuthenticationRemoteDataSource>(
    () => AuthenticationRemoteDataSourceImpl(
      firebaseAuth: sl(),
      googleSignIn: sl(),
    ),
  );
  sl.registerLazySingleton<AuthenticationLocalDataSource>(
    () => const AuthenticationLocalDataSourceImpl(),
  );

  // 2. Home
  sl.registerFactory(() => HomeBloc(getHomeUseCase: sl()));
  sl.registerLazySingleton(() => GetHomeUseCase(repository: sl()));
  sl.registerLazySingleton<HomeRepository>(
    () => HomeRepositoryImpl(
      remoteDataSource: sl(),
      localDataSource: sl(),
      networkInfo: sl(),
    ),
  );
  sl.registerLazySingleton<HomeRemoteDataSource>(
    () => const HomeRemoteDataSourceImpl(),
  );
  sl.registerLazySingleton<HomeLocalDataSource>(
    () => const HomeLocalDataSourceImpl(),
  );

  // 3. Product
  sl.registerFactory(
    () => ProductBloc(
      getProductsUseCase: sl(),
      getProductDetailsUseCase: sl(),
      addProductUseCase: sl(),
      updateProductUseCase: sl(),
      deleteProductUseCase: sl(),
      toggleProductStatusUseCase: sl(),
      searchProductsUseCase: sl(),
    ),
  );
  sl.registerLazySingleton(() => GetProductsUseCase(repository: sl()));
  sl.registerLazySingleton(() => GetProductDetailsUseCase(repository: sl()));
  sl.registerLazySingleton(() => AddProductUseCase(repository: sl()));
  sl.registerLazySingleton(() => UpdateProductUseCase(repository: sl()));
  sl.registerLazySingleton(() => DeleteProductUseCase(repository: sl()));
  sl.registerLazySingleton(() => ToggleProductStatusUseCase(repository: sl()));
  sl.registerLazySingleton(() => SearchProductsUseCase(repository: sl()));
  sl.registerLazySingleton<ProductRepository>(
    () => ProductRepositoryImpl(
      remoteDataSource: sl(),
      networkInfo: sl(),
    ),
  );
  sl.registerLazySingleton<ProductRemoteDataSource>(
    () => ProductRemoteDataSourceImpl(firestore: sl()),
  );
  sl.registerLazySingleton<ProductLocalDataSource>(
    () => const ProductLocalDataSourceImpl(),
  );

  // 4. Category
  sl.registerFactory(() => CategoryBloc(getCategoryUseCase: sl()));
  sl.registerLazySingleton(() => GetCategoryUseCase(repository: sl()));
  sl.registerLazySingleton<CategoryRepository>(
    () => CategoryRepositoryImpl(
      remoteDataSource: sl(),
      localDataSource: sl(),
      networkInfo: sl(),
    ),
  );
  sl.registerLazySingleton<CategoryRemoteDataSource>(
    () => const CategoryRemoteDataSourceImpl(),
  );
  sl.registerLazySingleton<CategoryLocalDataSource>(
    () => const CategoryLocalDataSourceImpl(),
  );

  // 5. Cart
  sl.registerFactory(() => CartBloc(getCartUseCase: sl()));
  sl.registerLazySingleton(() => GetCartUseCase(repository: sl()));
  sl.registerLazySingleton<CartRepository>(
    () => CartRepositoryImpl(
      remoteDataSource: sl(),
      localDataSource: sl(),
      networkInfo: sl(),
    ),
  );
  sl.registerLazySingleton<CartRemoteDataSource>(
    () => const CartRemoteDataSourceImpl(),
  );
  sl.registerLazySingleton<CartLocalDataSource>(
    () => const CartLocalDataSourceImpl(),
  );

  // 6. Wishlist
  sl.registerFactory(() => WishlistBloc(getWishlistUseCase: sl()));
  sl.registerLazySingleton(() => GetWishlistUseCase(repository: sl()));
  sl.registerLazySingleton<WishlistRepository>(
    () => WishlistRepositoryImpl(
      remoteDataSource: sl(),
      localDataSource: sl(),
      networkInfo: sl(),
    ),
  );
  sl.registerLazySingleton<WishlistRemoteDataSource>(
    () => const WishlistRemoteDataSourceImpl(),
  );
  sl.registerLazySingleton<WishlistLocalDataSource>(
    () => const WishlistLocalDataSourceImpl(),
  );

  // 7. Search
  sl.registerFactory(() => SearchBloc(getSearchUseCase: sl()));
  sl.registerLazySingleton(() => GetSearchUseCase(repository: sl()));
  sl.registerLazySingleton<SearchRepository>(
    () => SearchRepositoryImpl(
      remoteDataSource: sl(),
      localDataSource: sl(),
      networkInfo: sl(),
    ),
  );
  sl.registerLazySingleton<SearchRemoteDataSource>(
    () => const SearchRemoteDataSourceImpl(),
  );
  sl.registerLazySingleton<SearchLocalDataSource>(
    () => const SearchLocalDataSourceImpl(),
  );

  // 8. Orders
  sl.registerFactory(() => OrdersBloc(getOrdersUseCase: sl()));
  sl.registerLazySingleton(() => GetOrdersUseCase(repository: sl()));
  sl.registerLazySingleton<OrdersRepository>(
    () => OrdersRepositoryImpl(
      remoteDataSource: sl(),
      localDataSource: sl(),
      networkInfo: sl(),
    ),
  );
  sl.registerLazySingleton<OrdersRemoteDataSource>(
    () => const OrdersRemoteDataSourceImpl(),
  );
  sl.registerLazySingleton<OrdersLocalDataSource>(
    () => const OrdersLocalDataSourceImpl(),
  );

  // 9. Admin
  sl.registerFactory(() => AdminBloc(getAdminUseCase: sl()));
  sl.registerLazySingleton(() => GetAdminUseCase(repository: sl()));
  sl.registerLazySingleton<AdminRepository>(
    () => AdminRepositoryImpl(
      remoteDataSource: sl(),
      localDataSource: sl(),
      networkInfo: sl(),
    ),
  );
  sl.registerLazySingleton<AdminRemoteDataSource>(
    () => const AdminRemoteDataSourceImpl(),
  );
  sl.registerLazySingleton<AdminLocalDataSource>(
    () => const AdminLocalDataSourceImpl(),
  );
}
