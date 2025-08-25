part of 'module_bloc.dart';

enum ModuleStatus {
  init,
  loading,
  error,
  success,
}

@immutable
class ModuleState {
  final ModuleStatus status;
  final Message? message;
  final List<Module> modules;

  final int page;

  const ModuleState({
    this.status = ModuleStatus.init,
    this.message,
    this.page = 0,
    this.modules = const [],
  });

  ModuleState copyWith({
    ModuleStatus? status,
    Message? message,
    List<Module>? modules,
    int? page,
  }) =>
      ModuleState(
        status: status ?? this.status,
        message: message ?? this.message,
        page: page ?? this.page,
        modules: modules ?? this.modules,
      );
}
