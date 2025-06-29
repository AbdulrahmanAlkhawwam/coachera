import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/utils/app_util.dart';
import '../../domain/params/login_param.dart';
import '../../domain/params/register_param.dart';
import '../../domain/repositories/auth_repository.dart';
import '../../domain/use_cases/login_uc.dart';
import '../../domain/use_cases/register_uc.dart';
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
  Future<Either<Failure, void>> login(LoginParam param) async =>
      await AppUtils.safeCall(() async => await dataSource
          .login(param)
          .then((value) => storage.saveToken(value)));

  @override
  Future<Either<Failure, void>> logout() async =>
      await AppUtils.safeCall(() async =>
          await dataSource.logout().then((value) => storage.removeToken()));

  // @override
  // Future<Either<Failure, bool>> otp(String passkey) async =>
  //     await AppUtils.safeCall(() async => await dataSource.otp(passkey));


  @override
  Future<Either<Failure, void>> register(RegisterParam param) async =>
      await AppUtils.safeCall(() async => await dataSource.register(param));

}
