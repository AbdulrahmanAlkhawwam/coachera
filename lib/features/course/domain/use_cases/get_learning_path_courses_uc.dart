import 'package:coachera/features/course/domain/params/recommended_courses_param.dart';
import 'package:coachera/features/course/presentation/pages/recommended_courses_screen.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../../../home/domain/param/list_param.dart';
import '../entities/course.dart';
import '../repositories/course_repository.dart';

class GetLearningPathCoursesUC extends UseCase<List<Course>, int> {
  final CourseRepository repository;

  GetLearningPathCoursesUC({required this.repository});

  @override
  Future<Either<Failure, List<Course>>> call(int instructorId) async =>
      await repository.getInstructorCourses(instructorId);
}
