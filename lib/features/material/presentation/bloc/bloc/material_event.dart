part of 'material_bloc.dart';

@immutable
sealed class MaterialEvent {}

class GetMaterial extends MaterialEvent {
  final int materialId;

  GetMaterial({required this.materialId});
}
