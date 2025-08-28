import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/entity.dart';
import '../repositories/search_repository.dart';

class GetEntitiesUC extends UseCaseNoParam<List<Entity>> {
  final SearchRepository repository;

  GetEntitiesUC({required this.repository});

  @override
  Future<Either<Failure, List<Entity>>> call() async =>
      await repository.getEntities();
}
