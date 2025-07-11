import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../repositories/settings_repository.dart';

class GetThemeUC extends UseCaseNoParamNoFuture<ThemeMode> {
  final SettingsRepository repository;

  GetThemeUC({required this.repository});

  @override
  Either<Failure, ThemeMode> call() {
    return repository.getTheme();
  }
}

class SetThemeUC extends UseCase<bool, ThemeMode> {
  final SettingsRepository repository;

  SetThemeUC({required this.repository});

  @override
  Future<Either<Failure, bool>> call(ThemeMode param) {
    return repository.setTheme(param);
  }
}
