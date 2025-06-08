import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../params/register_param.dart';
import '../repositories/auth_repository.dart';

class RegisterUC extends UseCase< /*User*/ void, RegisterParam> {
  final AuthRepository repository;

  RegisterUC({required this.repository});

  @override
  Future<Either<Failure, /*user*/ void>> call(RegisterParam param) async {
    return await repository.register(param);
  }
}
