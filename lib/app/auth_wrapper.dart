import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:owlmart/features/authentication/presentation/bloc/authentication_bloc.dart';
import 'package:owlmart/features/authentication/presentation/bloc/authentication_state.dart';
import 'package:owlmart/features/authentication/presentation/pages/login_page.dart';
import 'package:owlmart/features/home/presentation/pages/main_navigation_page.dart';

class AuthWrapper extends StatelessWidget {
  const AuthWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthenticationBloc, AuthenticationState>(
      builder: (context, state) {
        if (state is AuthLoading) {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        } else if (state is Authenticated) {
          return MainNavigationPage(userId: state.user.uid);
        } else {
          // Unauthenticated or AuthError shows login page
          return const LoginPage();
        }
      },
    );
  }
}
