import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/utils/app_util.dart';
import '../../domain/entities/review.dart';
import '../../domain/repositories/review_repository.dart';
import '../data_source/review_remote_data_source.dart';

class ReviewRepositoryImpl extends ReviewRepository {
  final ReviewRemoteDataSource dataSource;

  ReviewRepositoryImpl({required this.dataSource});

  @override
  Future<Either<Failure, List<Review>>> getReviews() async =>
      await AppUtils.safeCall(() async => await dataSource.getReviews());

  @override
  Future<Either<Failure, List<Review>>> getCourseReview(int id) async =>
      await AppUtils.safeCall(() async => await dataSource.getCourseReview(id));
}
