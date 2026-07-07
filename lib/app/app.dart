import 'package:flutter/material.dart';
import 'package:owlmart/app/routes.dart';
import 'package:owlmart/app/theme.dart';

class OwlMartApp extends StatelessWidget {
  const OwlMartApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'OwlMart',
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system,
      initialRoute: AppRoutes.initial,
      onGenerateRoute: AppRoutes.onGenerateRoute,
      debugShowCheckedModeBanner: false,
    );
  }
}
