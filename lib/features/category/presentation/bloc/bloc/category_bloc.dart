import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../../../core/utils/message.dart';
import '../../../../home/domain/param/list_param.dart';
import '../../../domain/entities/category.dart';
import '../../../domain/use_cases/get_categories_uc.dart';

part 'category_event.dart';

part 'category_state.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  final GetCategoriesUC getCategoriesUC;

  CategoryBloc({
    required this.getCategoriesUC,
  }) : super(CategoryState()) {
    on<GetCategoryPaginated>(_getCategories);
  }

  FutureOr<void> _getCategories(
    GetCategoryPaginated event,
    Emitter<CategoryState> emit,
  ) async {
    emit(state.copyWith(status: CategoryStatus.loading));
    if (event.param.page == 0) {
      emit(state.copyWith(categories: []));
    }
    final response = await getCategoriesUC(event.param);
    response.fold(
      (failure) => emit(state.copyWith(
        status: CategoryStatus.error,
        message: Message.fromFailure(failure),
      )),
      (categories) => emit(state.copyWith(
          status: CategoryStatus.success,
          categories: [...state.categories, ...categories],
          page: event.param.page)),
    );
  }
}
