part of 'instructor_bloc.dart';

enum InstructorStatus {
  init,
  loading,
  error,
  success,
}

@immutable
class InstructorState {
  final InstructorStatus status;
  final Message? message;
  final bool hasMore;
  final int page;

  // final List<Course> courses;

  const InstructorState({
    this.status = InstructorStatus.init,
    this.message,
    this.hasMore = true,
    this.page = 0,
    // this.courses = const [],
  });

  InstructorState copyWith({
    InstructorStatus? status,
    Message? message,
    // List<Course>? courses,
    bool? hasMore,
    int? page,
  }) =>
      InstructorState(
        status: status ?? this.status,
        message: message ?? this.message,
        hasMore: hasMore ?? this.hasMore,
        page: page ?? this.page,
        // courses: courses ?? this.courses,
      );
}
