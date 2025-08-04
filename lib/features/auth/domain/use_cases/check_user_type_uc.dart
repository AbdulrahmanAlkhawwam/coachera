import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../../presentation/manager/bloc/auth_bloc.dart';
import '../repositories/auth_repository.dart';

class CheckUserTypeUC extends UseCaseNoParam<UserStatus> {
  final AuthRepository repository;

  CheckUserTypeUC({required this.repository});

  @override
  Future<Either<Failure, UserStatus>> call() async {
    return await repository.checkUserType();
  }
}
