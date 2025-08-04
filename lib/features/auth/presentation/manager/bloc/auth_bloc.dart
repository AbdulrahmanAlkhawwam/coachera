import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../../../core/utils/message.dart';
import '../../../domain/params/change_password_param.dart';
import '../../../domain/params/forget_password_param.dart';
import '../../../domain/params/login_param.dart';
import '../../../domain/params/register_param.dart';
import '../../../domain/use_cases/change_password_uc.dart';
import '../../../domain/use_cases/check_user_type_uc.dart';
import '../../../domain/use_cases/forget_password_uc.dart';
import '../../../domain/use_cases/guest_login_uc.dart';
import '../../../domain/use_cases/login_uc.dart';
import '../../../domain/use_cases/logout_uc.dart';
import '../../../domain/use_cases/otp_uc.dart';
import '../../../domain/use_cases/register_uc.dart';

part 'auth_event.dart';

part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final LoginUC loginUC;
  final GuestLoginUc guestLoginUC;
  final LogoutUC logoutUC;
  final RegisterUC registerUC;
  final ForgetPasswordUC forgetPasswordUC;
  final ChangePasswordUC changePasswordUC;
  final OtpUC otpUC;
  final CheckUserTypeUC checkUserTypeUC;

  AuthBloc({
    required this.loginUC,
    required this.guestLoginUC,
    required this.forgetPasswordUC,
    required this.changePasswordUC,
    required this.checkUserTypeUC,
    required this.logoutUC,
    required this.otpUC,
    required this.registerUC,
  }) : super(AuthState()) {
    on<Login>(_onLogin);
    on<Logout>(_onLogout);
    on<GuestLogin>(_onGuestLogin);
    on<ChangePassword>(_onChangePassword);
    on<ForgetPassword>(_onForgetPassword);
    on<OTPValidation>(_onOtpValidation);
    on<Register>(_onRegister);
    on<CheckUserType>(_checkUserType);
  }

  FutureOr<void> _onLogin(Login event, Emitter<AuthState> emit) async {
    emit(state.copyWith(status: AuthStatus.loading));
    final response = await loginUC(event.param);
    response.fold(
      (failure) => emit(state.copyWith(
        status: AuthStatus.error,
        message: Message.fromFailure(failure),
      )),
      (_) => emit(state.copyWith(status: AuthStatus.authorized)),
    );
  }

  FutureOr<void> _onLogout(Logout event, Emitter<AuthState> emit) async {
    emit(state.copyWith(status: AuthStatus.loading));
    final response = await logoutUC();
    response.fold(
      (failure) => emit(state.copyWith(
        status: AuthStatus.error,
        message: Message.fromFailure(failure),
      )),
      (_) => emit(state.copyWith(status: AuthStatus.unauthorized)),
    );
  }

  FutureOr<void> _onRegister(Register event, Emitter<AuthState> emit) async {
    emit(state.copyWith(status: AuthStatus.loading));
    final response = await registerUC(event.param);
    response.fold(
      (failure) => emit(state.copyWith(
        status: AuthStatus.error,
        message: Message.fromFailure(failure),
      )),
      (_) => emit(state.copyWith(status: AuthStatus.authorized)),
    );
  }

  FutureOr<void> _onGuestLogin(
      GuestLogin event, Emitter<AuthState> emit) async {
    emit(state.copyWith(status: AuthStatus.loading));
    final response = await guestLoginUC();
    response.fold(
      (failure) => emit(state.copyWith(
        status: AuthStatus.error,
        message: Message.fromFailure(failure),
      )),
      (_) => emit(state.copyWith(status: AuthStatus.authorized)),
    );
  }

  FutureOr<void> _onForgetPassword(
    ForgetPassword event,
    Emitter<AuthState> emit,
  ) async {
    emit(state.copyWith(status: AuthStatus.loading));
    final response = await forgetPasswordUC(event.param);
    response.fold(
      (failure) => emit(state.copyWith(
        status: AuthStatus.error,
        message: Message.fromFailure(failure),
      )),
      (_) => emit(state.copyWith(status: AuthStatus.success)),
    );
  }

  FutureOr<void> _onOtpValidation(
    OTPValidation event,
    Emitter<AuthState> emit,
  ) async {
    emit(state.copyWith(status: AuthStatus.loading));
    final response = await otpUC(event.param);
    response.fold(
      (failure) => emit(state.copyWith(
        status: AuthStatus.error,
        message: Message.fromFailure(failure),
      )),
      (_) => emit(state.copyWith(
        status: AuthStatus.success,
        pin: event.param.password,
      )),
    );
  }

  FutureOr<void> _onChangePassword(
    ChangePassword event,
    Emitter<AuthState> emit,
  ) async {
    emit(state.copyWith(status: AuthStatus.loading));
    final response = await changePasswordUC(event.param);
    response.fold(
      (failure) => emit(state.copyWith(
        status: AuthStatus.error,
        message: Message.fromFailure(failure),
      )),
      (_) => emit(state.copyWith(status: AuthStatus.success)),
    );
  }

  FutureOr<void> _checkUserType(
      CheckUserType event, Emitter<AuthState> emit) async {
    emit(state.copyWith(status: AuthStatus.loading));
    final response = await checkUserTypeUC();
    response.fold(
      (failure) => emit(state.copyWith(
        status: AuthStatus.error,
        message: Message.fromFailure(failure),
      )),
      (userType) => emit(
          state.copyWith(status: AuthStatus.success, userStatus: userType)),
    );
  }
}
