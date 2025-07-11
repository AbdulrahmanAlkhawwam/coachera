import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';

import '../../../../core/error/failures.dart';

abstract class SettingsRepository {
  Either<Failure, ThemeMode> getTheme();

  Future<Either<Failure, bool>> setTheme(ThemeMode theme);
}
