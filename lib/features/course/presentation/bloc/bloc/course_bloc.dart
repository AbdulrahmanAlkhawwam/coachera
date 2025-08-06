import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:coachera/features/auth/domain/use_cases/logout_uc.dart';
import 'package:coachera/features/course/domain/use_cases/get_courses_uc.dart';
import 'package:meta/meta.dart';

import '../../../../../core/utils/message.dart';
import '../../../data/model/course_model.dart';
import '../../../domain/entities/course.dart';

part 'course_event.dart';

part 'course_state.dart';

class CourseBloc extends Bloc<CourseEvent, CourseState> {
  final GetCoursesUc getCoursesUc;

  CourseBloc({
    required this.getCoursesUc,
  }) : super(CourseState()) {
    on<GetCoursesPaginated>(_getCourses);
  }

  // FutureOr<void> _login(Login event, Emitter<AuthState> emit) async {
  //   emit(state.copyWith(status: AuthStatus.loading));
  //   final response = await loginUC(event.param);
  //   response.fold(
  //       (failure) => emit(state.copyWith(
  //             status: AuthStatus.error,
  //             message: Message.fromFailure(failure),
  //           )),
  //       (_) => emit(state.copyWith(status: AuthStatus.authorized)));
  // }

  // FutureOr<void> _logout(event, Emitter<AuthState> emit) async {
  //   emit(state.copyWith(status: AuthStatus.loading));
  //   final response = await logoutUC();
  //
  //   response.fold(
  //       (failure) => emit(state.copyWith(
  //             status: AuthStatus.error,
  //             message: Message.fromFailure(failure),
  //           )),
  //       (_) => emit(state.copyWith(status: AuthStatus.unauthorized)));
  // }
  //
  // FutureOr<void> _register(Register event, Emitter<AuthState> emit) async {
  //   emit(state.copyWith(status: AuthStatus.loading));
  //   final response = await registerUC(event.param);
  //   response.fold(
  //       (failure) => emit(state.copyWith(
  //           status: AuthStatus.error //todo: don't forget to add massage here
  //           )),
  //       (_) => emit(state.copyWith(status: AuthStatus.authorized)));
  // }

  Future<void> _getCourses(
    GetCoursesPaginated event,
    Emitter<CourseState> emit,
  ) async {
    emit(state.copyWith(status: CourseStatus.loading));

    final response = await getCoursesUc(event.page);
    response.fold(
        (failure) => emit(state.copyWith(
              status: CourseStatus.error,
              message: Message.fromFailure(failure),
            )),
        (courses) => emit(
              state.copyWith(
                status: CourseStatus.success,
                page: event.page + 1,
                courses: event.reset
                    ? courses
                    : [...(state.courses ?? []), ...courses],
                hasMore: courses.length == 10,
              ),
            ));
  }
// FutureOr<void> _getCourses(
//   GetCoursesPaginated event,
//   Emitter<CourseState> emit,
// ) async {
//   final isFirstPage = event.page == 0;
//
//   if (isFirstPage) {
//     emit(state.copyWith(
//       status: CourseStatus.loading,
//       courses: [],
//       message: null,
//     ));
//   }
//
//   final response = await getCoursesUc.call(event.page);
//
//   response.fold(
//     (failure) {
//       event.completer.completeError(Message.fromFailure(failure));
//       emit(state.copyWith(
//         status: CourseStatus.error,
//         message: Message.fromFailure(failure),
//       ));
//     },
//     (newCourses) {
//       final updatedCourses = List<Course>.from(state.courses ?? [])
//         ..addAll(newCourses);
//
//       event.completer.complete(newCourses);
//
//       emit(state.copyWith(
//         status: CourseStatus.success,
//         courses: updatedCourses,
//       ));
//     },
//   );
// }

// FutureOr<void> _getCourses(
//     GetCoursesPaginated event, Emitter<CourseState> emit) async {
//   emit(state.copyWith(status: CourseStatus.loading));
//   final response = await getCoursesUc.call();
//
//   response.fold(
//     (failure) => emit(state.copyWith(
//       status: CourseStatus.error,
//       message: Message.fromFailure(failure),
//     )),
//     (courses) {
//       event.completer.complete(courses);
//       emit(state.copyWith(
//       status: CourseStatus.success,
//       courses: courses,
//     ));
//     },
//   );
// }
}
