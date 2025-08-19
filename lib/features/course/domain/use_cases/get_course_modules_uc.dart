import 'package:coachera/features/course/domain/params/recommended_courses_param.dart';
import 'package:coachera/features/course/domain/repositories/module_repository.dart';
import 'package:coachera/features/course/presentation/pages/recommended_courses_screen.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/course.dart';
import '../entities/module.dart';
import '../repositories/course_repository.dart';

class GetCourseModulesUC extends UseCase<List<Module>, int> {
  final ModuleRepository repository;

  GetCourseModulesUC({required this.repository});

  @override
  Future<Either<Failure, List<Module>>> call(int courseId) async =>
      await repository.getCourseModules(courseId: courseId);
}
