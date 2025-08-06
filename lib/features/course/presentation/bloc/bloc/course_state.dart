part of 'course_bloc.dart';

enum CourseStatus {
  init,
  loading,
  error,
  success,
}

@immutable
class CourseState {
  final CourseStatus status;
  final Message? message;
  final bool hasMore;
  final int page;

  final List<Course> courses;

  const CourseState({
    this.status = CourseStatus.init,
    this.message,
    this.hasMore = true,
    this.page = 0,
    this.courses = const [],
  });

  CourseState copyWith({
    CourseStatus? status,
    Message? message,
    List<Course>? courses,
    bool? hasMore,
    int? page,
  }) =>
      CourseState(
        status: status ?? this.status,
        message: message ?? this.message,
        hasMore: hasMore ?? this.hasMore,
        page: page ?? this.page,
        courses: courses ?? this.courses,
      );
}
