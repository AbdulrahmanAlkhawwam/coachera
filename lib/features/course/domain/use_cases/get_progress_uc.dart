import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/progress.dart';
import '../repositories/course_repository.dart';

class GetProgressUC extends UseCaseNoParam<List<Progress>> {
  final CourseRepository repository;

  GetProgressUC({required this.repository});

  @override
  Future<Either<Failure, List<Progress>>> call() async =>
      await repository.getProgress();
}
