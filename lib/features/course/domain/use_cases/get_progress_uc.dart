import 'package:coachera/features/course/domain/params/recommended_courses_param.dart';
import 'package:coachera/features/course/presentation/pages/recommended_courses_screen.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../../../home/domain/param/list_param.dart';
import '../entities/course.dart';
import '../entities/progress.dart';
import '../repositories/course_repository.dart';

class GetProgressUC extends UseCaseNoParam<List<Progress>> {
  final CourseRepository repository;

  GetProgressUC({required this.repository});

  @override
  Future<Either<Failure, List<Progress>>> call() async =>
      await repository.getProgress();
}
