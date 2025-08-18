
import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/user.dart';
import '../repositories/auth_repository.dart';

class GetMeUC extends UseCaseNoParam<User> {
  final AuthRepository repository;

  GetMeUC({required this.repository});

  @override
  Future<Either<Failure, User>> call() async {
    return await repository.me();
  }
}
