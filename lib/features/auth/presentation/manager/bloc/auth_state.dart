part of 'auth_bloc.dart';

enum AuthStatus {
  init,
  loading,
  success,
  error,
  authorized,
  unauthorized,
}

enum UserStatus {
  unknown,
  student,
  guest,
  admin,
  teacher,
}

@immutable
class AuthState {
  final UserStatus userStatus;
  final AuthStatus status;
  final Message? message;
  final String? pin;

  const AuthState({
    this.userStatus = UserStatus.unknown,
    this.status = AuthStatus.init,
    this.message,
    this.pin,
  });

  AuthState copyWith({
    UserStatus? userStatus,
    AuthStatus? status,
    Message? message,
    String? pin,
  }) =>
      AuthState(
        userStatus: userStatus ?? this.userStatus,
        status: status ?? this.status,
        message: message ?? this.message,
        pin: pin ?? this.pin,
      );
}
