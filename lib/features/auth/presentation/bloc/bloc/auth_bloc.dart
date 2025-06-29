import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../../../core/utils/message.dart';
import '../../../domain/params/login_param.dart';
import '../../../domain/params/register_param.dart';
import '../../../domain/use_cases/login_uc.dart';
import '../../../domain/use_cases/logout_uc.dart';
import '../../../domain/use_cases/register_uc.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final LoginUC loginUC;
  final LogoutUC logoutUC;
  final RegisterUC registerUC;

  AuthBloc({
    required this.loginUC,
    required this.logoutUC,
    required this.registerUC,
  }) : super(AuthState()) {
    on<Login>(_login);
    on<Logout>(_logout);
    on<Register>(_register);
  }

  FutureOr<void> _login(Login event, Emitter<AuthState> emit) async {
    emit(state.copyWith(status: AuthStatus.loading));
    final response = await loginUC(event.param);
    response.fold(
        (failure) => emit(state.copyWith(
              status: AuthStatus.error,
              message: Message.fromFailure(failure),
            )),
        (_) => emit(state.copyWith(status: AuthStatus.authorized)));
  }

  FutureOr<void> _logout(event, Emitter<AuthState> emit) async {
    emit(state.copyWith(status: AuthStatus.loading));
    final response = await logoutUC();
    response.fold(
        (failure) => emit(state.copyWith(
              status: AuthStatus.error,
              message: Message.fromFailure(failure),
            )),
        (_) => emit(state.copyWith(status: AuthStatus.unauthorized)));
  }

  FutureOr<void> _register(Register event, Emitter<AuthState> emit) async {
    emit(state.copyWith(status: AuthStatus.loading));
    final response = await registerUC(event.param);
    response.fold(
        (failure) => emit(state.copyWith(
              status: AuthStatus.error,
              message: Message.fromFailure(failure),
            )),
        (_) => emit(state.copyWith(status: AuthStatus.authorized)));
  }
}
