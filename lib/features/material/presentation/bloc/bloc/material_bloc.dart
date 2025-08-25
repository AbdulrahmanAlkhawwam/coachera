import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:coachera/features/material/domain/use_cases/get_material_uc.dart';
import 'package:meta/meta.dart';

import '../../../../../core/utils/message.dart';
import '../../../domain/entities/material.dart';

part 'material_event.dart';

part 'material_state.dart';

class MaterialBloc extends Bloc<MaterialEvent, MaterialState> {
  final GetMaterialUC getMaterialUC;

  MaterialBloc({
    required this.getMaterialUC,
  }) : super(MaterialState()) {
    on<GetMaterial>(_getMaterial);
  }

  FutureOr<void> _getMaterial(
      GetMaterial event, Emitter<MaterialState> emit) async {
    emit(state.copyWith(status: MaterialStatus.loading));
    final response = await getMaterialUC(event.materialId);
    response.fold(
      (failure) => emit(state.copyWith(
        status: MaterialStatus.error,
        message: Message.fromFailure(failure),
      )),
      (material) => emit(state.copyWith(
        status: MaterialStatus.success,
        material: material,
      )),
    );
  }
}
