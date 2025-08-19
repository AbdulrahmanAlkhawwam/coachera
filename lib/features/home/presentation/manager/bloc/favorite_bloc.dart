import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../../../core/utils/message.dart';
import '../../../../course/domain/entities/course.dart';
import '../../../domain/use_cases/add_favorite_uc.dart';
import '../../../domain/use_cases/delete_favorite_uc.dart';
import '../../../domain/use_cases/get_favorite_uc.dart';
import '../../../domain/use_cases/get_favorites_uc.dart';

part 'favorite_event.dart';

part 'favorite_state.dart';

class FavoriteBloc extends Bloc<FavoriteEvent, FavoriteState> {
  final GetFavoritesUc getFavoritesUc;
  final DeleteFavoriteUc deleteFavoriteUc;
  final AddFavoriteUc addFavoriteUc;
  final GetFavoriteUC getFavoritesUC;

  FavoriteBloc({
    required this.getFavoritesUc,
    required this.addFavoriteUc,
    required this.deleteFavoriteUc,
    required this.getFavoritesUC,
  }) : super(FavoriteState()) {
    on<GetFavorites>(_getFavorites);
    on<DeleteFavorite>(_deleteFavorite);
    on<AddFavorite>(_addFavorite);
    on<GetFavorite>(_getFavorite);
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

  FutureOr<void> _getFavorites(
      GetFavorites event, Emitter<FavoriteState> emit) async {
    emit(state.copyWith(status: FavoriteStatus.loading));
    final response = await getFavoritesUc.call();
    response.fold(
        (failure) => emit(state.copyWith(
              status: FavoriteStatus.error,
              message: Message.fromFailure(failure),
            )),
        (courses) => emit(state.copyWith(
              status: FavoriteStatus.success,
              courses: courses,
            )));
  }

  FutureOr<void> _deleteFavorite(
      DeleteFavorite event, Emitter<FavoriteState> emit) async {
    emit(state.copyWith(status: FavoriteStatus.loading));
    final response = await deleteFavoriteUc.call(event.courseId);
    response.fold(
        (failure) => emit(state.copyWith(
              status: FavoriteStatus.error,
              message: Message.fromFailure(failure),
            )),
        (_) => emit(state.copyWith(
              status: FavoriteStatus.success,
              isFavorite: false,
            )));
  }

  FutureOr<void> _addFavorite(
      AddFavorite event, Emitter<FavoriteState> emit) async {
    emit(state.copyWith(status: FavoriteStatus.loading));
    final response = await addFavoriteUc.call(event.courseId);
    response.fold(
        (failure) => emit(state.copyWith(
              status: FavoriteStatus.error,
              message: Message.fromFailure(failure),
            )),
        (_) => emit(state.copyWith(
              status: FavoriteStatus.success,
              isFavorite: true,
            )));
  }

  FutureOr<void> _getFavorite(
      GetFavorite event, Emitter<FavoriteState> emit) async {
    emit(state.copyWith(status: FavoriteStatus.loading));
    final response = await getFavoritesUC(event.courseId);
    response.fold(
      (failure) => emit(state.copyWith(
        status: FavoriteStatus.error,
        message: Message.fromFailure(failure),
      )),
      (isFavorite) => emit(
        state.copyWith(
          status: FavoriteStatus.success,
          isFavorite: isFavorite,
        ),
      ),
    );
  }
}
