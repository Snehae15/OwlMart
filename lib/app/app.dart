import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:owlmart/app/routes.dart';
import 'package:owlmart/app/theme.dart';
import 'package:owlmart/core/di/injection.dart' as di;

import 'package:owlmart/features/authentication/presentation/bloc/authentication_bloc.dart';
import 'package:owlmart/features/authentication/presentation/bloc/authentication_event.dart';
import 'package:owlmart/features/cart/presentation/bloc/cart_bloc.dart';
import 'package:owlmart/features/wishlist/presentation/bloc/wishlist_bloc.dart';
import 'package:owlmart/features/admin/presentation/bloc/admin_bloc.dart';
import 'package:owlmart/features/home/presentation/bloc/home_bloc.dart';
import 'package:owlmart/features/product/presentation/bloc/product_bloc.dart';
import 'package:owlmart/features/category/presentation/bloc/category_bloc.dart';
import 'package:owlmart/features/search/presentation/bloc/search_bloc.dart';
import 'package:owlmart/features/orders/presentation/bloc/orders_bloc.dart';

class OwlMartApp extends StatelessWidget {
  const OwlMartApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthenticationBloc>(
          create: (_) => di.sl<AuthenticationBloc>()..add(const AuthCheckRequested()),
        ),
        BlocProvider<HomeBloc>(create: (_) => di.sl<HomeBloc>()),
        BlocProvider<ProductBloc>(create: (_) => di.sl<ProductBloc>()),
        BlocProvider<CategoryBloc>(create: (_) => di.sl<CategoryBloc>()),
        BlocProvider<CartBloc>(create: (_) => di.sl<CartBloc>()),
        BlocProvider<WishlistBloc>(create: (_) => di.sl<WishlistBloc>()),
        BlocProvider<SearchBloc>(create: (_) => di.sl<SearchBloc>()),
        BlocProvider<OrdersBloc>(create: (_) => di.sl<OrdersBloc>()),
        BlocProvider<AdminBloc>(create: (_) => di.sl<AdminBloc>()),
      ],
      child: MaterialApp(
        title: 'OwlMart',
        theme: AppTheme.lightTheme,
        darkTheme: AppTheme.darkTheme,
        themeMode: ThemeMode.system,
        initialRoute: AppRoutes.initial,
        onGenerateRoute: AppRoutes.onGenerateRoute,
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
