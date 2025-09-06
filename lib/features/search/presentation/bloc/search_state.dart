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
  final String? input;

  final int page;

  final List<Entity> entities;
  final List<dynamic> output;
  final List<Course> courses;

  const SearchState({
    this.status = SearchStatus.init,
    this.message,
    this.page = 0,
    this.input,
    this.entities = const [],
    this.output = const [],
    this.courses = const [],
  });

  SearchState copyWith({
    SearchStatus? status,
    Message? message,
    String? input,
    int? page,
    List<Entity>? entities,
    List<dynamic>? output,
    List<Course>? courses,
  }) =>
      SearchState(
        status: status ?? this.status,
        message: message ?? this.message,
        page: page ?? this.page,
        input: input ?? this.input,
        entities: entities ?? this.entities,
        output: output ?? this.output,
        courses: courses ?? this.courses,
      );
}
