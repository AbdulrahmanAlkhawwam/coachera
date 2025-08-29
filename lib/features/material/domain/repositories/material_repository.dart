import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../entities/material.dart';
import '../param/quiz_param.dart';

abstract class MaterialRepository {
  Future<Either<Failure, Material>> getMaterial({required int materialId});

  Future<Either<Failure, void>> submitQuiz({required QuizParam param});
}
