part of 'auth_bloc.dart';

enum AuthStatus {
  init,
  loading,
  success,
  error,
  authorized,
  unauthorized,
}

@immutable
class AuthState {
  final AuthStatus status;
  final Message? message;
  final String? pin;

  const AuthState({
    this.status = AuthStatus.init,
    this.message,
    this.pin,
  });

  AuthState copyWith({
    AuthStatus? status,
    Message? message,
    String? pin,
  }) =>
      AuthState(
        status: status ?? this.status,
        message: message ?? this.message,
        pin: pin ?? this.pin,
      );
}
