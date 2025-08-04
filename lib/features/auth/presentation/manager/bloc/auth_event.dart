part of 'auth_bloc.dart';

@immutable
sealed class AuthEvent {
  const AuthEvent();
}

class CheckUserType extends AuthEvent {
  const CheckUserType();
}

class Login extends AuthEvent {
  final LoginParam param;

  const Login({required this.param});
}

class GuestLogin extends AuthEvent {
  const GuestLogin();
}

class Logout extends AuthEvent {
  const Logout();
}

class Register extends AuthEvent {
  final RegisterParam param;

  const Register({required this.param});
}

class ForgetPassword extends AuthEvent {
  final ForgetPasswordParam param;

  const ForgetPassword({required this.param});
}

class OTPValidation extends AuthEvent {
  final LoginParam param;

  const OTPValidation({required this.param});
}

class ChangePassword extends AuthEvent {
  final ChangePasswordParam param;

  const ChangePassword({required this.param});
}
