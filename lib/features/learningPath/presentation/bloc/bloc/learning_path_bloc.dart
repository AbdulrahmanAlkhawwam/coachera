import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../../../core/utils/message.dart';
import '../../../../home/domain/param/list_param.dart';
import '../../../domain/entities/learning_path.dart';
import '../../../domain/use_cases/get_learning_paths_uc.dart';

part 'learning_path_event.dart';

part 'learning_path_state.dart';

class LearningPathBloc extends Bloc<LearningPathEvent, LearningPathState> {
  final GetLearningPathsUC getLearningPathsUC;

  LearningPathBloc({
    required this.getLearningPathsUC,
  }) : super(LearningPathState()) {
    on<GetLearningPaths>(_getLearningPaths);
  }

// Future<void> _getRecommendedCourses(
//   GetRecommendedCourses event,
//   Emitter<CourseState> emit,
// ) async {
//   emit(state.copyWith(status: CourseStatus.loading));
//
//   final response = await getRecommendedCoursesUc(event.param);
//   response.fold(
//     (failure) => emit(state.copyWith(
//       status: CourseStatus.error,
//       message: Message.fromFailure(failure),
//     )),
//     (recommendedCourses) => emit(
//       state.copyWith(
//         status: CourseStatus.success,
//         page: event.param.page! + 1,
//         courses: event.reset
//             ? recommendedCourses
//             : [...(state.courses ?? []), ...recommendedCourses],
//         hasMore: recommendedCourses.length == 10,
//       ),
//     ),
//   );
// }

  FutureOr<void> _getLearningPaths(
      GetLearningPaths event, Emitter<LearningPathState> emit) async {
    emit(state.copyWith(status: LearningPathStatus.loading));
    if (event.param.page == 0) {
      emit(state.copyWith(learningPath: []));
    }
    final response = await getLearningPathsUC(event.param);
    response.fold(
      (failure) => emit(state.copyWith(
        status: LearningPathStatus.error,
        message: Message.fromFailure(failure),
      )),
      (learningPaths) => emit(state.copyWith(
          status: LearningPathStatus.success,
          learningPath: [...state.learningPath, ...learningPaths],
          page: event.param.page)),
    );
  }
}
