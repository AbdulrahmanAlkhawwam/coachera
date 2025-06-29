import 'package:coachera/features/course/presentation/pages/courses_screen.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/course.dart';
import '../repositories/course_repository.dart';

class GetCoursesUc extends UseCase<List<Course>, int> {
  final CourseRepository repository;

  GetCoursesUc({required this.repository});

  @override
  Future<Either<Failure, List<Course>>> call(int? page) async =>
      await repository.getCourses(page: page);
}
