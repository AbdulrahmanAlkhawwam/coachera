import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../../../core/utils/message.dart';
import '../../../domain/entities/category.dart';
import '../../../domain/use_cases/get_categories_uc.dart';

part 'category_event.dart';

part 'category_state.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  final GetCategoriesUc getCategoriesUc;

  CategoryBloc({
    required this.getCategoriesUc,
  }) : super(CategoryState()) {
    on<GetCategoryPaginated>(_getCategories);
  }

  FutureOr<void> _getCategories(
    GetCategoryPaginated event,
    Emitter<CategoryState> emit,
  ) async {
    final isFirstPage = event.page == 0;

    if (isFirstPage) {
      emit(state.copyWith(
        status: CourseStatus.loading,
        courses: [],
        message: null,
      ));
    }

    final response = await getCategoriesUc.call(event.page);

    response.fold(
      (failure) {
        event.completer.completeError(Message.fromFailure(failure));
        emit(state.copyWith(
          status: CourseStatus.error,
          message: Message.fromFailure(failure),
        ));
      },
      (newCourses) {
        final updatedCourses = List<Category>.from(state.courses ?? [])
          ..addAll(newCourses);

        event.completer.complete(newCourses);

        emit(state.copyWith(
          status: CourseStatus.success,
          courses: updatedCourses,
        ));
      },
    );
  }
}
