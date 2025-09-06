import 'package:coachera/core/error/failures.dart';
import 'package:coachera/features/app.dart';

import 'package:coachera/features/material/domain/entities/material.dart';
import 'package:coachera/features/material/domain/param/quiz_param.dart';

import 'package:dartz/dartz.dart';

import '../../../../core/utils/app_util.dart';
import '../../domain/param/complete_lesson.dart';
import '../../domain/repositories/material_repository.dart';
import '../data_source/material_remote_data_source.dart';

class MaterialRepositoryImpl extends MaterialRepository {
  final MaterialRemoteDataSource dataSource;

  MaterialRepositoryImpl({required this.dataSource});

  @override
  Future<Either<Failure, Material>> getMaterial(
          {required int materialId}) async =>
      await AppUtils.safeCall(
          () async => await dataSource.getMaterial(id: materialId));

  @override
  Future<Either<Failure, void>> submitQuiz({required QuizParam param}) async =>
      await AppUtils.safeCall(() async => await dataSource.submitQuiz(param));

  @override
  Future<Either<Failure, void>> completeLesson(
      CompleteLessonParam param) async =>
      await AppUtils.safeCall(
              () async => await dataSource.completeLesson(param));
}
