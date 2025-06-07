import 'package:dartz/dartz.dart';

import '../error/failures.dart';

abstract class UseCase<T, Param> {
  Future<Either<Failure, T>> call(Param param);
}

abstract class UseCaseNoParam<T> {
  Future<Either<Failure, T>> call();
}

abstract class UseCaseNoParamNoFuture<T> {
  Either<Failure, T> call();
}

abstract class UseCaseNoFuture<T, Param> {
  Either<Failure, T> call(param);
}
