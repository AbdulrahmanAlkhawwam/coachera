import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../../../core/utils/message.dart';
import '../../../domain/entities/review.dart';
import '../../../domain/use_cases/get_course_review_uc.dart';
import '../../../domain/use_cases/get_reviews_uc.dart';

part 'review_event.dart';

part 'review_state.dart';

class ReviewBloc extends Bloc<ReviewEvent, ReviewState> {
  final GetReviewsUC getReviewsUC;
  final GetCourseReviewUC getCourseReviewUC;

  ReviewBloc({
    required this.getReviewsUC,
    required this.getCourseReviewUC,
  }) : super(ReviewState()) {
    on<GetReviews>(_getReviews);
    on<GetCourseReview>(_getCourseReviews);
  }

  FutureOr<void> _getCourseReviews(
      GetCourseReview event, Emitter<ReviewState> emit) async {
    emit(state.copyWith(status: ReviewStatus.loading));
    final response = await getCourseReviewUC(event.courseId);
    response.fold(
      (failure) => emit(state.copyWith(
        status: ReviewStatus.error,
        message: Message.fromFailure(failure),
      )),
      (reviews) => emit(state.copyWith(
        status: ReviewStatus.success,
        reviews: reviews,
      )),
    );
  }

  FutureOr<void> _getReviews(
      GetReviews event, Emitter<ReviewState> emit) async {
    emit(state.copyWith(status: ReviewStatus.loading));
    final response = await getReviewsUC();
    response.fold(
      (failure) => emit(state.copyWith(
        status: ReviewStatus.error,
        message: Message.fromFailure(failure),
      )),
      (reviews) => emit(state.copyWith(
        status: ReviewStatus.success,
        reviews: reviews,
      )),
    );
  }
}
