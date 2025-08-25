part of 'review_bloc.dart';

@immutable
sealed class ReviewEvent {}

class GetCourseReview extends ReviewEvent {
  final int courseId;

  GetCourseReview({required this.courseId});
}

class GetReviews extends ReviewEvent {}
// class GetCategoryPaginated extends CategoryEvent {
//   final int page;
//   final Completer<List<Category>> completer;
//
//   GetCategoryPaginated({
//     required this.page,
//     required this.completer,
//   });
// }
