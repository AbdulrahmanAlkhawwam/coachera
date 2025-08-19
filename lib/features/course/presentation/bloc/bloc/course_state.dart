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
  final List<Module> modules;

  final int page;

  final List<Course> courses;

  const CourseState({
    this.status = CourseStatus.init,
    this.message,
    this.hasMore = true,
    this.page = 0,
    this.modules = const [],
    this.courses = const [],
  });

  CourseState copyWith({
    CourseStatus? status,
    Message? message,
    List<Course>? courses,
    bool? hasMore,
    int? page,
    List<Module>? modules,
  }) =>
      CourseState(
        status: status ?? this.status,
        message: message ?? this.message,
        hasMore: hasMore ?? this.hasMore,
        page: page ?? this.page,
        modules: modules ?? this.modules,
        courses: courses ?? this.courses,
      );
}
