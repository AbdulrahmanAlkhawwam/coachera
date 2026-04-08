import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/course.dart';
import '../repositories/course_repository.dart';

class GetInstructorCoursesUC extends UseCase<List<Course>, int> {
  final CourseRepository repository;

  GetInstructorCoursesUC({required this.repository});

  @override
  Future<Either<Failure, List<Course>>> call(int instructorId) async =>
      await repository.getInstructorCourses(instructorId);
}
