import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:coachera/features/search/domain/entities/entity.dart';
import 'package:coachera/features/search/domain/use_cases/get_entities_uc.dart';
import 'package:coachera/features/search/domain/use_cases/get_search_courses_uc.dart';
import 'package:coachera/features/search/domain/use_cases/search_uc.dart';
import 'package:meta/meta.dart';

import '../../../../core/utils/message.dart';
import '../../../course/domain/entities/course.dart';
import '../../domain/params/search_param.dart';

part 'search_event.dart';

part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final GetEntitiesUC getEntitiesUC;
  final GetSearchCoursesUc getSearchCoursesUc ;
  final SearchUC searchUC;

  SearchBloc({
    required this.getEntitiesUC,
    required this.getSearchCoursesUc,
    required this.searchUC,
  }) : super(SearchState()) {
    on<GetEntities>(_getEntities);
    on<Search>(_search);
    on<GetSearchCourses>(_searchCourses);
  }

  // FutureOr<void> _getCategories(
  //   GetCategoryPaginated event,
  //   Emitter<CategoryState> emit,
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
  //   final response = await getCategoriesUc.call(event.page);
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
  //       final updatedCourses = List<Category>.from(state.courses ?? [])
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

  FutureOr<void> _getEntities(
      GetEntities event, Emitter<SearchState> emit) async {
    if (state.entities.isNotEmpty) {
      return;
    }
    emit(state.copyWith(status: SearchStatus.loading));
    final response = await getEntitiesUC();
    response.fold(
      (failure) => emit(state.copyWith(
        status: SearchStatus.error,
        message: Message.fromFailure(failure),
      )),
      (entities) => emit(state.copyWith(
        status: SearchStatus.success,
        entities: entities,
      )),
    );
  }

  FutureOr<void> _search(Search event, Emitter<SearchState> emit) async {
    if (event.param.input == "") {
      emit(state.copyWith(status: SearchStatus.success, output: []));
    }
    emit(state.copyWith(status: SearchStatus.loading));
    final response = await searchUC(event.param);
    response.fold(
      (failure) => emit(state.copyWith(
        status: SearchStatus.error,
        message: Message.fromFailure(failure),
      )),
      (output) => emit(state.copyWith(
        status: SearchStatus.success,
        output: output,
      )),
    );
  }

  FutureOr<void> _searchCourses(GetSearchCourses event, Emitter<SearchState> emit) async {

    emit(state.copyWith(status: SearchStatus.loading));
    if (event.param.param.page == 0) {
      emit(state.copyWith(courses: []));
    }
    final response = await getSearchCoursesUc(event.param);
    response.fold(
          (failure) => emit(state.copyWith(
        status:  SearchStatus.error,
        message: Message.fromFailure(failure),
      )),
          (recommendedCourses) => emit(
        state.copyWith(
          status:  SearchStatus.success,
          page: event.param.param.page,
          courses: [...state.courses, ...recommendedCourses],
        ),
      ),
    );

  }
}
