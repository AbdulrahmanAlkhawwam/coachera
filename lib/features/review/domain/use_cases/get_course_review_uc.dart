import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/review.dart';
import '../repositories/review_repository.dart';

class GetCourseReviewUC extends UseCase<List<Review>, int> {
  final ReviewRepository repository;

  GetCourseReviewUC({required this.repository});

  @override
  Future<Either<Failure, List<Review>>> call(int id) async =>
      await repository.getCourseReview(id);
}
