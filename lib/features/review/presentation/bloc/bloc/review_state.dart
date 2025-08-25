part of 'review_bloc.dart';

enum ReviewStatus {
  init,
  loading,
  error,
  success,
}

@immutable
class ReviewState {
  final ReviewStatus status;
  final Message? message;
  final List<Review>? reviews;

  const ReviewState({
    this.status = ReviewStatus.init,
    this.message,
    this.reviews,
  });

  ReviewState copyWith({
    ReviewStatus? status,
    Message? message,
    List<Review>? reviews,
  }) =>
      ReviewState(
        status: status ?? this.status,
        message: message ?? this.message,
        reviews: reviews ?? this.reviews,
      );
}
