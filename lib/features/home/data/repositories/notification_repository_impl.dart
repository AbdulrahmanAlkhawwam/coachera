import 'package:coachera/core/utils/app_util.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../domain/repositories/notification_repository.dart';
import '../data_source/notification_remote_data_source.dart';
import '../model/notification_model.dart';

class NotificationRepositoryImpl extends NotificationRepository {
  final NotificationRemoteDataSource dataSource;

  NotificationRepositoryImpl({
    required this.dataSource,
  });

  @override
  Future<Either<Failure, int>> getUnreadNotification() async =>
      await AppUtils.safeCall(() async => await dataSource.fetchUnreadCount());

  @override
  Future<Either<Failure, List<NotificationModel>>> getMyNotification() async =>
      await AppUtils.safeCall(
          () async => await dataSource.fetchNotifications());

  @override
  Future<Either<Failure, void>> markNotifications(int id) async =>
      await AppUtils.safeCall(
          () async => await dataSource.markNotificationsRead(id));

// @override
// Either<Failure, ThemeMode> getTheme() {
//   final themeIndex = localDataSource.loadThemeIndex();
//   return Right(ThemeMode.values[themeIndex ?? 0]);
// }
//
// @override
// Future<Either<Failure, bool>> setTheme(ThemeMode theme) async {
//   try {
//     await localDataSource.saveThemeIndex(theme.index);
//     return Right(true);
//   } catch (e) {
//     return Left(DataNotFoundFailure());
//   }
// }
}
