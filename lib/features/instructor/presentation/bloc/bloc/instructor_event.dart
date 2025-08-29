part of 'instructor_bloc.dart';

@immutable
sealed class InstructorEvent {}

class GetInstructors extends InstructorEvent {
  final ListParam param;

  GetInstructors({
    required this.param,
  });
}
