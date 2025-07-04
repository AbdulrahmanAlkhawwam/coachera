part of 'favorite_bloc.dart';

@immutable
sealed class FavoriteEvent {}

class GetFavorites extends FavoriteEvent {}

class DeleteFavorite extends FavoriteEvent {
  final int courseId ;
  DeleteFavorite({required this.courseId});
}

class AddFavorite extends FavoriteEvent {
  final int courseId ;
  AddFavorite({required this.courseId});
}
