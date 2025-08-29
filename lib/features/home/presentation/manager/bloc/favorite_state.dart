part of 'favorite_bloc.dart';

enum FavoriteStatus {
  init,
  loading,
  error,
  success,
}

@immutable
class FavoriteState {
  final FavoriteStatus status;
  final Message? message;
  final List<Course> courses;
  final bool? isFavorite ;

  const FavoriteState({
    this.status = FavoriteStatus.init,
    this.message,
    this.courses = const [],
    this.isFavorite,
  });

  FavoriteState copyWith({
    FavoriteStatus? status,
    Message? message,
    List<Course>? courses,
    bool? isFavorite,
  }) =>
      FavoriteState(
        status: status ?? this.status,
        message: message ?? this.message,
        courses: courses ?? this.courses,
        isFavorite: isFavorite ?? this.isFavorite,
      );
}
