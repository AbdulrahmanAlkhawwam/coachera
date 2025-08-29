import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:coachera/features/material/domain/use_cases/get_material_uc.dart';
import 'package:coachera/features/material/domain/use_cases/submit_quiz_uc.dart';
import 'package:meta/meta.dart';

import '../../../../../core/utils/message.dart';
import '../../../domain/entities/material.dart';
import '../../../domain/param/quiz_param.dart';

part 'material_event.dart';

part 'material_state.dart';

class MaterialBloc extends Bloc<MaterialEvent, MaterialState> {
  final GetMaterialUC getMaterialUC;
  final SubmitQuizUC submitQuizUC;

  MaterialBloc({
    required this.getMaterialUC,
    required this.submitQuizUC,
  }) : super(MaterialState()) {
    on<GetMaterial>(_getMaterial);
    on<SubmitQuiz>(_submitQuiz);
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

  FutureOr<void> _submitQuiz(
      SubmitQuiz event, Emitter<MaterialState> emit) async {
    emit(state.copyWith(status: MaterialStatus.loading));
    final response = await submitQuizUC(event.param);

    response.fold(
      (failure) => emit(state.copyWith(
        status: MaterialStatus.error,
        message: Message.fromFailure(failure),
      )),
      (_) => emit(state.copyWith(status: MaterialStatus.success)),
    );
  }
}
