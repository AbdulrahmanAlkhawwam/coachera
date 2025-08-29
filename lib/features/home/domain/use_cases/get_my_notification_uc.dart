import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/notification.dart';
import '../repositories/favorite_repository.dart';
import '../repositories/notification_repository.dart';

class GetMyNotificationUC extends UseCaseNoParam<List<Notification>> {
  final NotificationRepository repository;

  GetMyNotificationUC({required this.repository});

  @override
  Future<Either<Failure, List<Notification>>> call() async =>
      await repository.getMyNotification();
}
