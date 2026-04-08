import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/enrollment.dart';
import '../repositories/course_repository.dart';

class EnrollCourseUC extends UseCase<Enrollment, int> {
  final CourseRepository repository;

  EnrollCourseUC({required this.repository});

  @override
  Future<Either<Failure, Enrollment>> call(int courseId) async =>
      await repository.enroll(courseId);
}
