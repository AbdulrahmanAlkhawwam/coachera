import 'package:coachera/features/course/domain/params/recommended_courses_param.dart';
import 'package:coachera/features/course/presentation/pages/recommended_courses_screen.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../../../home/domain/param/list_param.dart';
import '../entities/course.dart';
import '../entities/enrollment.dart';
import '../repositories/course_repository.dart';

class EnrollCourseUC extends UseCase<Enrollment, int> {
  final CourseRepository repository;

  EnrollCourseUC({required this.repository});

  @override
  Future<Either<Failure, Enrollment>> call(int courseId) async =>
      await repository.enroll(courseId);
}
