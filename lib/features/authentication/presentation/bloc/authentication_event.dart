import 'package:equatable/equatable.dart';

abstract class AuthenticationEvent extends Equatable {
  const AuthenticationEvent();

  @override
  List<Object?> get props => [];
}

class AuthCheckRequested extends AuthenticationEvent {
  const AuthCheckRequested();
}

class LoginWithEmailRequested extends AuthenticationEvent {
  final String email;
  final String password;

  const LoginWithEmailRequested({required this.email, required this.password});

  @override
  List<Object?> get props => [email, password];
}

class LoginWithGoogleRequested extends AuthenticationEvent {
  const LoginWithGoogleRequested();
}

class LogoutRequested extends AuthenticationEvent {
  const LogoutRequested();
}
