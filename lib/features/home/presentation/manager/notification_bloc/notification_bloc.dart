import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../../../core/utils/message.dart';
import '../../../domain/entities/notification.dart';
import '../../../domain/use_cases/get_my_notification_uc.dart';
import '../../../domain/use_cases/get_unread_notification_uc.dart';
import '../../../domain/use_cases/mark_notification_uc.dart';

part 'notification_event.dart';

part 'notification_state.dart';

class NotificationBloc extends Bloc<NotificationEvent, NotificationState> {
  final GetUnreadNotificationUC getUnreadNotificationUC;
  final GetMyNotificationUC getMyNotificationUC;
  final MarkNotificationUC markNotificationUC;

  NotificationBloc({
    required this.getUnreadNotificationUC,
    required this.getMyNotificationUC,
    required this.markNotificationUC,
  }) : super(NotificationState()) {
    on<GetUnreadNotification>(_getUnreadNotification);
    on<GetMyNotifications>(_getMyNotification);
    on<MarkNotification>(_markNotification);
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

  FutureOr<void> _getUnreadNotification(
      GetUnreadNotification event, Emitter<NotificationState> emit) async {
    emit(state.copyWith(status: NotificationStatus.loading));
    final response = await getUnreadNotificationUC();
    response.fold(
        (failure) => emit(state.copyWith(
              status: NotificationStatus.error,
              message: Message.fromFailure(failure),
            )),
        (count) => emit(state.copyWith(
              status: NotificationStatus.success,
              unreadNotification: count,
            )));
  }

  FutureOr<void> _getMyNotification(
      GetMyNotifications event, Emitter<NotificationState> emit) async {
    emit(state.copyWith(status: NotificationStatus.loading));
    final response = await getMyNotificationUC();
    response.fold(
        (failure) => emit(state.copyWith(
              status: NotificationStatus.error,
              message: Message.fromFailure(failure),
            )),
        (notifications) => emit(state.copyWith(
              status: NotificationStatus.success,
              notification: notifications,
            )));
  }

  FutureOr<void> _markNotification(
      MarkNotification event, Emitter<NotificationState> emit) async {
    emit(state.copyWith(status: NotificationStatus.loading));
    final response = await markNotificationUC(event.id);
    response.fold(
        (failure) => emit(state.copyWith(
              status: NotificationStatus.error,
              message: Message.fromFailure(failure),
            )),
        (_) => add(GetMyNotifications()));
  }
}
