import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/review.dart';
import '../repositories/review_repository.dart';

class GetReviewsUC extends UseCaseNoParam<List<Review>> {
  final ReviewRepository repository;

  GetReviewsUC({required this.repository});

  @override
  Future<Either<Failure, List<Review>>> call() async =>
      await repository.getReviews();
}
