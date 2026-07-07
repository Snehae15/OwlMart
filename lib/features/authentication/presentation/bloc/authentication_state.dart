import 'package:equatable/equatable.dart';
import '../../domain/entities/user_entity.dart';

abstract class AuthenticationState extends Equatable {
  const AuthenticationState();

  @override
  List<Object?> get props => [];
}

class AuthInitial extends AuthenticationState {
  const AuthInitial();
}

class AuthLoading extends AuthenticationState {
  const AuthLoading();
}

class Authenticated extends AuthenticationState {
  final UserEntity user;

  const Authenticated({required this.user});

  @override
  List<Object?> get props => [user];
}

class Unauthenticated extends AuthenticationState {
  const Unauthenticated();
}

class AuthError extends AuthenticationState {
  final String message;

  const AuthError({required this.message});

  @override
  List<Object?> get props => [message];
}
