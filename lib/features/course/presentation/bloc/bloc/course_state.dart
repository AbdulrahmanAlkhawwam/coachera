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
  final List<Course>? courses;

  const CourseState({
    this.status = CourseStatus.init,
    this.message,
    this.courses = const [],
  });

  CourseState copyWith({
    CourseStatus? status,
    Message? message,
    List<Course>? courses,
  }) =>
      CourseState(
        status: status ?? this.status,
        message: message ?? this.message,
        courses: courses ?? this.courses,
      );
}
