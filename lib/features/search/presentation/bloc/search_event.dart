part of 'search_bloc.dart';

@immutable
sealed class SearchEvent {}

class GetEntities extends SearchEvent {}
