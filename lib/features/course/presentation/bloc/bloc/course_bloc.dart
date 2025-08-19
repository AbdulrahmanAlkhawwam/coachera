import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../../../core/utils/message.dart';
import '../../../domain/entities/course.dart';
import '../../../domain/entities/module.dart';
import '../../../domain/params/recommended_courses_param.dart';
import '../../../domain/use_cases/get_course_modules_uc.dart';
import '../../../domain/use_cases/get_recommended_courses_uc.dart';

part 'course_event.dart';

part 'course_state.dart';

class CourseBloc extends Bloc<CourseEvent, CourseState> {
  final GetRecommendedCoursesUC getRecommendedCoursesUc;
  final GetCourseModulesUC getCourseModulesUC;

  CourseBloc({
    required this.getRecommendedCoursesUc,
    required this.getCourseModulesUC,
  }) : super(CourseState()) {
    on<GetRecommendedCourses>(_getRecommendedCourses);
    on<GetModules>(_getCourseModules);
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

  FutureOr<void> _getCourseModules(
      GetModules event, Emitter<CourseState> emit) async {
    emit(state.copyWith(status: CourseStatus.loading));
    final response = await getCourseModulesUC(event.courseId);

    response.fold(
        (failure) => emit(state.copyWith(
              status: CourseStatus.error,
              message: Message.fromFailure(failure),
            )),
        (modules) => emit(state.copyWith(
              status: CourseStatus.success,
              modules: modules,
            )));
  }
}
