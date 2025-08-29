import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';

import '../../../course/domain/entities/course.dart';
import '../entities/notification.dart';

abstract class NotificationRepository {
  Future<Either<Failure, int>> getUnreadNotification();

  Future<Either<Failure, List<Notification>>> getMyNotification();

  Future<Either<Failure, void>> markNotifications(int id);
}
