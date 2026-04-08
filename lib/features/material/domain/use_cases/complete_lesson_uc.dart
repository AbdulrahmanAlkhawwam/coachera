import 'package:coachera/features/material/domain/repositories/material_repository.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../param/complete_lesson.dart';

class CompleteLessonUC extends UseCase<void, CompleteLessonParam> {
  final MaterialRepository repository;

  CompleteLessonUC({required this.repository});

  @override
  Future<Either<Failure, void>> call(CompleteLessonParam param) async =>
      await repository.completeLesson(param);
}
