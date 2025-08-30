part of 'search_bloc.dart';

@immutable
sealed class SearchEvent {}

class GetEntities extends SearchEvent {}

class Search extends SearchEvent {
  final SearchParam param;

  Search({required this.param});
}
