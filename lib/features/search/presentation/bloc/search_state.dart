part of 'search_bloc.dart';

enum SearchStatus {
  init,
  loading,
  error,
  success,
}

@immutable
class SearchState {
  final SearchStatus status;
  final Message? message;
  final List<Entity> entities;

  const SearchState({
    this.status = SearchStatus.init,
    this.message,
    this.entities = const [],
  });

  SearchState copyWith({
    SearchStatus? status,
    Message? message,
    List<Entity>? entities,
  }) =>
      SearchState(
        status: status ?? this.status,
        message: message ?? this.message,
        entities: entities ?? this.entities,
      );
}
