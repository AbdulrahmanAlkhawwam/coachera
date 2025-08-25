part of 'module_bloc.dart';

@immutable
sealed class ModuleEvent {}

class GetModules extends ModuleEvent {
  final int courseId;

  GetModules({required this.courseId});
}
