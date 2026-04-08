import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../../../home/domain/param/list_param.dart';
import '../entities/instructor.dart';
import '../repositories/instructor_repository.dart';

class GetInstructorsUC extends UseCase<List<Instructor>, ListParam> {
  final InstructorRepository repository;

  GetInstructorsUC({required this.repository});

  @override
  Future<Either<Failure, List<Instructor>>> call(param) async =>
      await repository.getInstructors(param);
}
