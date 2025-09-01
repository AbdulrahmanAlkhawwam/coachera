import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:coachera/features/course/domain/use_cases/get_instructor_courses_uc.dart';
import 'package:coachera/features/course/domain/use_cases/get_learning_path_courses_uc.dart';
import 'package:coachera/features/course/domain/use_cases/get_progress_uc.dart';
import 'package:meta/meta.dart';

import '../../../../../core/utils/message.dart';
import '../../../../home/domain/param/list_param.dart';
import '../../../domain/entities/course.dart';
import '../../../domain/entities/progress.dart';
import '../../../domain/use_cases/enroll_course_uc.dart';
import '../../../domain/use_cases/get_recommended_courses_uc.dart';

part 'course_event.dart';

part 'course_state.dart';

class CourseBloc extends Bloc<CourseEvent, CourseState> {
  final GetRecommendedCoursesUC getRecommendedCoursesUc;
  final GetInstructorCoursesUC getInstructorCoursesUC;
  final GetLearningPathCoursesUC getLearningPathCoursesUC;
  final GetProgressUC getProgressUC;
  final EnrollCourseUC enrollCourseUc;

  CourseBloc({
    required this.getLearningPathCoursesUC,
    required this.getRecommendedCoursesUc,
    required this.getInstructorCoursesUC,
    required this.getProgressUC,
    required this.enrollCourseUc,
  }) : super(CourseState()) {
    on<GetRecommendedCourses>(_getRecommendedCourses);
    on<GetInstructorCourses>(_getInstructorCourses);
    on<GetLearningPathCourses>(_getLearningPathCourses);
    on<GetUserCourses>(_getUserCourses);
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

  FutureOr<void> _getInstructorCourses(
      GetInstructorCourses event, Emitter<CourseState> emit) async {
    emit(state.copyWith(status: CourseStatus.loading));
    emit(state.copyWith(courses: []));
    final response = await getInstructorCoursesUC(event.instructorId);

    response.fold(
        (failure) => emit(state.copyWith(
              status: CourseStatus.error,
              message: Message.fromFailure(failure),
            )),
        (instructorCourses) => emit(state.copyWith(
              status: CourseStatus.success,
              courses: instructorCourses,
            )));
  }

  FutureOr<void> _getUserCourses(
      GetUserCourses event, Emitter<CourseState> emit) async {
    emit(state.copyWith(status: CourseStatus.loading, progress: []));

    final response = await getProgressUC();
    response.fold(
      (failure) => emit(state.copyWith(
        status: CourseStatus.error,
        message: Message.fromFailure(failure),
      )),
      (progress) => emit(
        state.copyWith(
          status: CourseStatus.success,
          progress: progress,
        ),
      ),
    );
  }

  FutureOr<void> _getLearningPathCourses(
      GetLearningPathCourses event, Emitter<CourseState> emit) async {
    emit(state.copyWith(status: CourseStatus.loading, courses: []));

    final response = await getLearningPathCoursesUC(event.learningPathId);
    response.fold(
      (failure) => emit(state.copyWith(
        status: CourseStatus.error,
        message: Message.fromFailure(failure),
      )),
      (courses) => emit(
        state.copyWith(
          status: CourseStatus.success,
          courses: courses,
        ),
      ),
    );
  }
}
