import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../params/login_param.dart';
import '../repositories/auth_repository.dart';

class OtpUC extends UseCase<bool, LoginParam> {
  final AuthRepository repository;

  OtpUC({required this.repository});

  @override
  Future<Either<Failure, bool>> call(LoginParam param) async {
    return await repository.otp(param);
  }
}
