import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/module.dart';
import '../repositories/module_repository.dart';

class GetCourseModulesUC extends UseCase<List<Module>, int> {
  final ModuleRepository repository;

  GetCourseModulesUC({required this.repository});

  @override
  Future<Either<Failure, List<Module>>> call(int courseId) async =>
      await repository.getCourseModules(courseId: courseId);
}
