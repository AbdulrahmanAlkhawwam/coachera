import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:coachera/features/auth/domain/params/register_param.dart';
import 'package:coachera/features/auth/domain/use_cases/register_uc.dart';
import 'package:meta/meta.dart';

import '../../../domain/params/login_param.dart';
import '../../../domain/use_cases/login_uc.dart';

part 'auth_event.dart';

part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final LoginUC loginUC;
  final RegisterUC registerUC;

  AuthBloc({
    required this.loginUC,
    required this.registerUC,
  }) : super(AuthState()) {
    on<Login>(_login);
    on<Register>(_register);
  }

  FutureOr<void> _login(Login event, Emitter<AuthState> emit) async {
    emit(state.copyWith(status: AuthStatus.loading));
    final response = await loginUC(event.param);
    response.fold(
        (failure) => emit(state.copyWith(
            status: AuthStatus.error //todo: don't forget to add massage here
            )),
        (_) => emit(state.copyWith(status: AuthStatus.authorized)));
  }
  FutureOr<void> _register(Register event, Emitter<AuthState> emit) async {
    emit(state.copyWith(status: AuthStatus.loading));
    final response = await registerUC(event.param);
    response.fold(
        (failure) => emit(state.copyWith(
            status: AuthStatus.error //todo: don't forget to add massage here
            )),
        (_) => emit(state.copyWith(status: AuthStatus.authorized)));
  }
}
