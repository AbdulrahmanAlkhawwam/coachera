import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../param/quiz_param.dart';
import '../repositories/material_repository.dart';


class SubmitQuizUC extends UseCase<void, QuizParam> {
  final MaterialRepository repository;

  SubmitQuizUC({required this.repository});

  @override
  Future<Either<Failure, void>> call(QuizParam param) async =>
      await repository.submitQuiz(param: param);
}
