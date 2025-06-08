
import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
// import '../../../home/domain/entities/user.dart';
import '../params/login_param.dart';
import '../params/register_param.dart';
import '../use_cases/login_uc.dart';
import '../use_cases/register_uc.dart';

abstract class AuthRepository {
  // Future<Either<Failure, void>> deleteToken();

  Future<Either<Failure, void>> login(LoginParam param);

  Future<Either<Failure, void>> logout();

  // Future<Either<Failure, User>> register(RegisterParam param);
  Future<Either<Failure,void>> register(RegisterParam param);

  // Future<Either<Failure, bool>> otp(String passkey);

  // Future<Either<Failure, bool>> checkToken();

  // Future<Either<Failure, void>> saveToken(String token);

 }
