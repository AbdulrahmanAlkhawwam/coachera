import 'package:coachera/features/course/domain/params/recommended_courses_param.dart';
import 'package:coachera/features/course/presentation/pages/recommended_courses_screen.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/course.dart';
import '../repositories/course_repository.dart';

class GetRecommendedCoursesUC
    extends UseCase<List<Course>, RecommendedCoursesParam> {
  final CourseRepository repository;

  GetRecommendedCoursesUC({required this.repository});

  @override
  Future<Either<Failure, List<Course>>> call(
          RecommendedCoursesParam param) async =>
      await repository.getRecommendedCourses(
        page: param.page,
        filter: param.filter,
      );
}
