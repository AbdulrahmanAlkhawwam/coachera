import 'package:coachera/features/course/domain/params/recommended_courses_param.dart';
import 'package:coachera/features/course/presentation/pages/recommended_courses_screen.dart';
import 'package:coachera/features/material/domain/repositories/material_repository.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../../../home/domain/param/list_param.dart';
import '../../../course/domain/entities/course.dart';
import '../../../course/domain/entities/enrollment.dart';
import '../param/complete_lesson.dart';
import '../../../course/domain/repositories/course_repository.dart';

class CompleteLessonUC extends UseCase<void, CompleteLessonParam> {
  final MaterialRepository repository;

  CompleteLessonUC({required this.repository});

  @override
  Future<Either<Failure, void>> call(CompleteLessonParam param) async =>
      await repository.completeLesson(param);
}
