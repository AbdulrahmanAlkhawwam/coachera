part of 'instructor_bloc.dart';

@immutable
sealed class InstructorEvent {}

class GetInstructors extends InstructorEvent {
  final ListParam param;

  GetInstructors({
    required this.param,
  });
}

class GetCourseInstructors extends InstructorEvent {
  final int courseId;

  GetCourseInstructors({required this.courseId});
}
