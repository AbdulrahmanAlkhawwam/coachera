import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../params/login_param.dart';
import '../repositories/auth_repository.dart';

class LoginUC extends UseCase<void, LoginParam> {
  final AuthRepository repository;

  LoginUC({required this.repository});

  @override
  Future<Either<Failure, void>> call(LoginParam param) async {
    return await repository.login(param);
  }
}
