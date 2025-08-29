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
  final List<Instructor> instructors;

  const InstructorState({
    this.status = InstructorStatus.init,
    this.message,
    this.hasMore = true,
    this.page = 0,
    this.instructors = const [],
  });

  InstructorState copyWith({
    InstructorStatus? status,
    Message? message,
    List<Instructor>? instructors,
    bool? hasMore,
    int? page,
  }) =>
      InstructorState(
        status: status ?? this.status,
        message: message ?? this.message,
        hasMore: hasMore ?? this.hasMore,
        page: page ?? this.page,
        instructors: instructors ?? this.instructors,
      );
}
