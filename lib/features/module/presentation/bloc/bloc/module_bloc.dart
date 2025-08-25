import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../../../core/utils/message.dart';
import '../../../domain/entities/module.dart';
import '../../../domain/use_cases/get_course_modules_uc.dart';

part 'module_event.dart';

part 'module_state.dart';

class ModuleBloc extends Bloc<ModuleEvent, ModuleState> {
  final GetCourseModulesUC getCourseModulesUC;

  ModuleBloc({
    required this.getCourseModulesUC,
  }) : super(ModuleState()) {
    on<GetModules>(_getCourseModules);
  }

  FutureOr<void> _getCourseModules(
      GetModules event, Emitter<ModuleState> emit) async {
    emit(state.copyWith(status: ModuleStatus.loading));
    final response = await getCourseModulesUC(event.courseId);

    response.fold(
        (failure) => emit(state.copyWith(
              status: ModuleStatus.error,
              message: Message.fromFailure(failure),
            )),
        (modules) => emit(state.copyWith(
              status: ModuleStatus.success,
              modules: modules,
            )));
  }
}
