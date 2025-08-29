
import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../../../home/domain/param/list_param.dart';
import '../entities/learning_path.dart';
import '../repositories/learning_path_repository.dart';

class GetLearningPathsUC extends UseCase<List<LearningPath>, ListParam> {
  final LearningPathRepository repository;

  GetLearningPathsUC({required this.repository});

  @override
  Future<Either<Failure, List<LearningPath>>> call(param) async =>
      await repository.getLearningPaths(param);
}
