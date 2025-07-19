import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../params/forget_password_param.dart';
import '../repositories/auth_repository.dart';

class ForgetPasswordUC extends UseCase<void, ForgetPasswordParam> {
  final AuthRepository repository;

  ForgetPasswordUC({required this.repository});

  @override
  Future<Either<Failure, void>> call(ForgetPasswordParam param) async {
    return await repository.forgetPassword(param);
  }
}
