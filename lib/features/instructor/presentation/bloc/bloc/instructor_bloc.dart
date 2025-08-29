import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../../../core/utils/message.dart';
import '../../../../home/domain/param/list_param.dart';
import '../../../domain/entities/instructor.dart';
import '../../../domain/use_cases/get_instructors_uc.dart';

part 'instructor_event.dart';

part 'instructor_state.dart';

class InstructorBloc extends Bloc<InstructorEvent, InstructorState> {
  final GetInstructorsUC getInstructorsUC;

  InstructorBloc({
    required this.getInstructorsUC,
  }) : super(InstructorState()) {
    on<GetInstructors>(_getInstructor);
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
}
