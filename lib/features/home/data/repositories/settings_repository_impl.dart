import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';

import '../../../../core/error/failures.dart';
import '../../domain/repositories/settings_repository.dart';
import '../data_source/settings_local_data_source.dart';

class SettingsRepositoryImpl extends SettingsRepository {
  final SettingsLocalDataSource localDataSource;

  SettingsRepositoryImpl({
    required this.localDataSource,
  });

  @override
  Either<Failure, ThemeMode> getTheme() {
    final themeIndex = localDataSource.loadThemeIndex();
    return Right(ThemeMode.values[themeIndex ?? 0]);
  }

  @override
  Future<Either<Failure, bool>> setTheme(ThemeMode theme) async {
    try {
      await localDataSource.saveThemeIndex(theme.index);
      return Right(true);
    } catch (e) {
      return Left(DataNotFoundFailure());
    }
  }
}
