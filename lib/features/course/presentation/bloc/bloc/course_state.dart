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
  final int page;
  final List<Course> courses;
  final List<Progress> progress;

  const CourseState({
    this.status = CourseStatus.init,
    this.message,
    this.page = 0,
    this.courses = const [],
    this.progress = const []
  });

  CourseState copyWith({
    CourseStatus? status,
    Message? message,
    List<Course>? courses,
    List<Progress> ?progress,
    bool? hasMore,
    int? page,
  }) =>
      CourseState(
        status: status ?? this.status,
        message: message ?? this.message,
        page: page ?? this.page,
        courses: courses ?? this.courses,
        progress:progress ?? this.progress
        ,
      );
}
