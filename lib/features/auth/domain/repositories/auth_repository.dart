import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../presentation/manager/bloc/auth_bloc.dart';
import '../entities/user.dart';
import '../params/change_password_param.dart';
import '../params/forget_password_param.dart';
import '../params/login_param.dart';
import '../params/register_param.dart';

abstract class AuthRepository {
  Future<Either<Failure, void>> login(LoginParam param);

  Future<Either<Failure, void>> logout();

  Future<Either<Failure, void>> register(RegisterParam param);

  Future<Either<Failure, void>> guestLogin();

  Future<Either<Failure, void>> localLogout();

  Future<Either<Failure, void>> forgetPassword(ForgetPasswordParam param);

  Future<Either<Failure, void>> changePassword(ChangePasswordParam param);

  Future<Either<Failure, UserStatus>> checkUserType();

  Future<Either<Failure, bool>> otp(LoginParam param);

  Future<Either<Failure, User>> me();
}
