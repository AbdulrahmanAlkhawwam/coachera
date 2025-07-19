import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../repositories/auth_repository.dart';

class GuestLoginUc extends UseCaseNoParam<void> {
  final AuthRepository repository;

  GuestLoginUc({required this.repository});

  @override
  Future<Either<Failure, void>> call() async {
    return await repository.guestLogin();
  }
}
