import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../../../home/domain/param/list_param.dart';
import '../../presentation/pages/instructors_screen.dart';
import '../entities/instructor.dart';
import '../repositories/instructor_repository.dart';

class GetCourseInstructorsUC extends UseCase<List<Instructor>, int> {
  final InstructorRepository repository;

  GetCourseInstructorsUC({required this.repository});

  @override
  Future<Either<Failure, List<Instructor>>> call(int courseId) async =>
      await repository.getCourseInstructors(courseId);
}
