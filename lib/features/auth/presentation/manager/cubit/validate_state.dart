part of 'validate_cubit.dart';

@immutable
sealed class ValidateState {}

final class InitState extends ValidateState {}

final class ChangeState extends ValidateState {}