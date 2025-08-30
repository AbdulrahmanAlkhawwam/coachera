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
  final List<dynamic> output;

  const SearchState({
    this.status = SearchStatus.init,
    this.message,
    this.entities = const [],
    this.output = const [],
  });

  SearchState copyWith({
    SearchStatus? status,
    Message? message,
    List<Entity>? entities,
    List<dynamic>? output,
  }) =>
      SearchState(
        status: status ?? this.status,
        message: message ?? this.message,
        entities: entities ?? this.entities,
        output: output ?? this.output,
      );
}
