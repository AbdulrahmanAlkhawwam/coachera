import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../../../core/utils/message.dart';

part 'learning_path_event.dart';

part 'learning_path_state.dart';

class LearningPathBloc extends Bloc<LearningPathEvent, LearningPathState> {
  // final GetRecommendedCoursesUC getRecommendedCoursesUc;

  LearningPathBloc(/*{
    // required this.getRecommendedCoursesUc,
  }*/
      )
      : super(LearningPathState()) {
    // on<GetRecommendedCourses>(_getRecommendedCourses);
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
}
