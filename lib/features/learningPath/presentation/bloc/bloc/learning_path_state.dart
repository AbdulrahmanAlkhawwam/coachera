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

  final int page;

  final List<LearningPath> learningPath;

  const LearningPathState({
    this.status = LearningPathStatus.init,
    this.message,
    this.page = 0,
    this.learningPath = const [],
  });

  LearningPathState copyWith({
    LearningPathStatus? status,
    Message? message,
    List<LearningPath>? learningPath,
    bool? hasMore,
    int? page,
  }) =>
      LearningPathState(
        status: status ?? this.status,
        message: message ?? this.message,
        page: page ?? this.page,
        learningPath: learningPath ?? this.learningPath,
      );
}
