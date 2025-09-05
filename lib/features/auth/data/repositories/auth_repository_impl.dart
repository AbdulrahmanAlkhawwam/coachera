import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/utils/app_util.dart';
import '../../domain/entities/user.dart';
import '../../domain/params/change_password_param.dart';
import '../../domain/params/forget_password_param.dart';
import '../../domain/params/login_param.dart';
import '../../domain/params/register_param.dart';
import '../../domain/repositories/auth_repository.dart';
import '../../presentation/manager/bloc/auth_bloc.dart';
import '../data_source/auth_local_data_source.dart';
import '../data_source/auth_remote_data_source.dart';

class AuthRepositoryImpl extends AuthRepository {
  final AuthRemoteDataSource dataSource;
  final AuthLocalDataSource storage;

  AuthRepositoryImpl({
    required this.dataSource,
    required this.storage,
  });

  @override
  Future<Either<Failure, void>> login(LoginParam param) async {
    return await AppUtils.safeCall(() async {
      final token = await dataSource.login(param);
      storage.removeGuest();
      storage.setToken(token);
      await dataSource.registerDeviceToken(token);
    });
  }

  @override
  Future<Either<Failure, void>> logout() async =>
      await AppUtils.safeCall(() async => storage.getToken() == null
          ? await localLogout()
          : await dataSource.logout().then((_) => localLogout()));

  @override
  Future<Either<Failure, bool>> otp(LoginParam param) async =>
      await AppUtils.safeCall(() async => await dataSource.otp(param));

  @override
  Future<Either<Failure, void>> register(RegisterParam param) async {
    return await AppUtils.safeCall(() async {
      await dataSource.register(param);
      storage.removeGuest();
      await login(LoginParam(email: param.email, password: param.password));/*dataSource
          .login(LoginParam(email: param.email, password: param.password))*/
          // .then((token) async => await dataSource.registerDeviceToken(token));
    });
  }

  @override
  Future<Either<Failure, void>> guestLogin() async {
    return AppUtils.safeCall(() async => await storage.guestLogin());
  }

  @override
  Future<Either<Failure, void>> localLogout() async {
    return await AppUtils.safeCall(() async => await storage.localLogout());
  }

  @override
  Future<Either<Failure, void>> forgetPassword(
          ForgetPasswordParam param) async =>
      await AppUtils.safeCall(
          () async => await dataSource.forgetPassword(param));

  @override
  Future<Either<Failure, void>> changePassword(
          ChangePasswordParam param) async =>
      await AppUtils.safeCall(
          () async => await dataSource.changePassword(param));

  @override
  Future<Either<Failure, UserStatus>> checkUserType() async =>
      await AppUtils.safeCall(() async => storage.getToken() == null
          ? storage.getGuest() == true
              ? UserStatus.guest
              : UserStatus.unknown
          : UserStatus.student);

  @override
  Future<Either<Failure, User>> me() async =>
      await AppUtils.safeCall(() async => await dataSource.getMe());
}
