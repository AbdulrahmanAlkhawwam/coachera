part of 'category_bloc.dart';

@immutable
sealed class CategoryEvent {}

class GetCategoryPaginated extends CategoryEvent {
  final ListParam param;

  GetCategoryPaginated({required this.param});
}
