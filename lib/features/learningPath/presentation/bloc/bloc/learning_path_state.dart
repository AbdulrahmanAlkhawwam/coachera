part of 'learning_path_bloc.dart';

enum LearningPathStatus {
  init,
  loading,
  error,
  success,
}

@immutable
class LearningPathState {
  final LearningPathStatus status;
  final Message? message;
  final bool hasMore;

  final int page;

  // final List<Course> courses;

  const LearningPathState({
    this.status = LearningPathStatus.init,
    this.message,
    this.hasMore = true,
    this.page = 0,
    // this.courses = const [],
  });

  LearningPathState copyWith({
    LearningPathStatus? status,
    Message? message,
    // List<Course>? courses,
    bool? hasMore,
    int? page,
  }) =>
      LearningPathState(
        status: status ?? this.status,
        message: message ?? this.message,
        hasMore: hasMore ?? this.hasMore,
        page: page ?? this.page,
        // courses: courses ?? this.courses,
      );
}
