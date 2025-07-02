part of 'auth_bloc.dart';

@immutable
sealed class AuthEvent {}

class Login extends AuthEvent {
  final LoginParam param;

  Login({required this.param});
}

class Logout extends AuthEvent {}

class Register extends AuthEvent {
  final RegisterParam param;

  Register({required this.param});
}
