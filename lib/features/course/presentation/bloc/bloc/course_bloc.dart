import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:coachera/features/course/domain/params/recommended_courses_param.dart';
import 'package:meta/meta.dart';

import '../../../../../core/utils/message.dart';
import '../../../../home/presentation/widgets/filter_sheet.dart';
import '../../../domain/entities/course.dart';
import '../../../domain/use_cases/get_recommended_courses_uc.dart';

part 'course_event.dart';

part 'course_state.dart';

class CourseBloc extends Bloc<CourseEvent, CourseState> {
  final GetRecommendedCoursesUC getRecommendedCoursesUc;

  CourseBloc({
    required this.getRecommendedCoursesUc,
  }) : super(CourseState()) {
    on<GetRecommendedCourses>(_getRecommendedCourses);
  }

  Future<void> _getRecommendedCourses(
    GetRecommendedCourses event,
    Emitter<CourseState> emit,
  ) async {
    emit(state.copyWith(status: CourseStatus.loading));

    final response = await getRecommendedCoursesUc(event.param);
    response.fold(
      (failure) => emit(state.copyWith(
        status: CourseStatus.error,
        message: Message.fromFailure(failure),
      )),
      (recommendedCourses) => emit(
        state.copyWith(
          status: CourseStatus.success,
          page: event.param.page! + 1,
          courses: event.reset
              ? recommendedCourses
              : [...(state.courses ?? []), ...recommendedCourses],
          hasMore: recommendedCourses.length == 10,
        ),
      ),
    );
  }
}
