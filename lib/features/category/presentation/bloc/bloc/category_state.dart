part of 'category_bloc.dart';

enum CategoryStatus {
  init,
  loading,
  error,
  success,
}

@immutable
class CategoryState {
  final CategoryStatus status;
  final Message? message;
  final int page;

  final List<Category> categories;

  const CategoryState({
    this.status = CategoryStatus.init,
    this.message,
    this.page = 0,
    this.categories = const [],
  });

  CategoryState copyWith({
    CategoryStatus? status,
    Message? message,
    int? page,
    List<Category>? categories,
  }) =>
      CategoryState(
        status: status ?? this.status,
        message: message ?? this.message,
        page: page ?? this.page,
        categories: categories ?? this.categories,
      );
}
