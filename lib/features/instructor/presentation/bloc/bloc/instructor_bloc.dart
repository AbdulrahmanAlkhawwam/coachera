import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:coachera/features/instructor/domain/use_cases/get_course_instructors_uc.dart';
import 'package:meta/meta.dart';

import '../../../../../core/utils/message.dart';
import '../../../../home/domain/param/list_param.dart';
import '../../../domain/entities/instructor.dart';
import '../../../domain/use_cases/get_instructors_uc.dart';

part 'instructor_event.dart';

part 'instructor_state.dart';

class InstructorBloc extends Bloc<InstructorEvent, InstructorState> {
  final GetInstructorsUC getInstructorsUC;
  final GetCourseInstructorsUC getCourseInstructorsUC;

  InstructorBloc({
    required this.getInstructorsUC,
    required this.getCourseInstructorsUC,
  }) : super(InstructorState()) {
    on<GetInstructors>(_getInstructor);
    on<GetCourseInstructors>(_getCourseInstructor);
  }

  FutureOr<void> _getInstructor(
      GetInstructors event, Emitter<InstructorState> emit) async {
    emit(state.copyWith(status: InstructorStatus.loading));
    if (event.param.page == 0) {
      emit(state.copyWith(instructors: []));
    }
    final response = await getInstructorsUC(event.param);
    response.fold(
      (failure) => emit(state.copyWith(
        status: InstructorStatus.error,
        message: Message.fromFailure(failure),
      )),
      (instructors) => emit(state.copyWith(
          status: InstructorStatus.success,
          instructors: [...state.instructors, ...instructors],
          page: event.param.page)),
    );
  }

  FutureOr<void> _getCourseInstructor(
      GetCourseInstructors event, Emitter<InstructorState> emit) async {
    emit(state.copyWith(status: InstructorStatus.loading));
    final response = await getCourseInstructorsUC(event.courseId);
    response.fold(
      (failure) => emit(state.copyWith(
        status: InstructorStatus.error,
        message: Message.fromFailure(failure),
      )),
      (instructors) => emit(state.copyWith(
        status: InstructorStatus.success,
        instructors: instructors,
      )),
    );
  }
}
