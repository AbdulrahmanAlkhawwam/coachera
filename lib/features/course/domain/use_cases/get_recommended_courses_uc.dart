import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../../../home/domain/param/list_param.dart';
import '../entities/course.dart';
import '../repositories/course_repository.dart';

class GetRecommendedCoursesUC extends UseCase<List<Course>, ListParam> {
  final CourseRepository repository;

  GetRecommendedCoursesUC({required this.repository});

  @override
  Future<Either<Failure, List<Course>>> call(ListParam param) async =>
      await repository.getRecommendedCourses(param);
}
