import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../../../core/utils/message.dart';
import '../../../../home/domain/param/list_param.dart';
import '../../../domain/entities/course.dart';
import '../../../domain/use_cases/enroll_course_uc.dart';
import '../../../domain/use_cases/get_recommended_courses_uc.dart';

part 'course_event.dart';

part 'course_state.dart';

class CourseBloc extends Bloc<CourseEvent, CourseState> {
  final GetRecommendedCoursesUC getRecommendedCoursesUc;
  final EnrollCourseUC enrollCourseUc;

  CourseBloc({
    required this.getRecommendedCoursesUc,
    required this.enrollCourseUc,
  }) : super(CourseState()) {
    on<GetRecommendedCourses>(_getRecommendedCourses);
    on<EnrollCourse>(_enrollCourse);
  }

  Future<void> _getRecommendedCourses(
    GetRecommendedCourses event,
    Emitter<CourseState> emit,
  ) async {
    emit(state.copyWith(status: CourseStatus.loading));
    if (event.param.page == 0) {
      emit(state.copyWith(courses: []));
    }
    final response = await getRecommendedCoursesUc(event.param);
    response.fold(
      (failure) => emit(state.copyWith(
        status: CourseStatus.error,
        message: Message.fromFailure(failure),
      )),
      (recommendedCourses) => emit(
        state.copyWith(
          status: CourseStatus.success,
          page: event.param.page,
          courses: [...state.courses, ...recommendedCourses],
        ),
      ),
    );
  }

  FutureOr<void> _enrollCourse(
      EnrollCourse event, Emitter<CourseState> emit) async {
    emit(state.copyWith(status: CourseStatus.loading));

    final response = await enrollCourseUc(event.courseId);
    response.fold(
      (failure) => emit(state.copyWith(
        status: CourseStatus.error,
        message: Message.fromFailure(failure),
      )),
      (_) => emit(state.copyWith(status: CourseStatus.success)),
    );
  }
}
