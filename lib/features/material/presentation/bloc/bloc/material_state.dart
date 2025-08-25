part of 'material_bloc.dart';

enum MaterialStatus {
  init,
  loading,
  error,
  success,
}

@immutable
class MaterialState {
  final MaterialStatus status;
  final Message? message;
  final Material? material;

  const MaterialState({
    this.status = MaterialStatus.init,
    this.message,
    this.material,
  });

  MaterialState copyWith({
    MaterialStatus? status,
    Message? message,
    Material? material,
  }) =>
      MaterialState(
        status: status ?? this.status,
        message: message ?? this.message,
        material: material ?? this.material,
      );
}
