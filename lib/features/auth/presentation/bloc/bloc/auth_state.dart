part of 'auth_bloc.dart';

enum AuthStatus {
  init,
  loading,
  checking,
  error,
  // notVerified,
  authorized,
  unauthorized,
}

@immutable
class AuthState {
  final AuthStatus status;
  // final Message? message;

  const AuthState({
    this.status = AuthStatus.init,
    // this.message,
  });

  AuthState copyWith({
    AuthStatus? status,
    // Message? message,
  }) =>
      AuthState(
        status: status ?? this.status,
        // message: message ?? this.message,
      );
}
