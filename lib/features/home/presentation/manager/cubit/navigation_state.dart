part of 'navigation_cubit.dart';

@immutable
sealed class NavigationState {}

final class InitState extends NavigationState {}

final class ChangeIndex extends NavigationState {}