import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../params/change_password_param.dart';
import '../repositories/auth_repository.dart';

class ChangePasswordUC extends UseCase<void, ChangePasswordParam> {
  final AuthRepository repository;

  ChangePasswordUC({required this.repository});

  @override
  Future<Either<Failure, void>> call(ChangePasswordParam param) async {
    return await repository.changePassword(param);
  }
}
