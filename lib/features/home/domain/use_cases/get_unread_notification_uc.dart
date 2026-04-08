import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../repositories/notification_repository.dart';

class GetUnreadNotificationUC extends UseCaseNoParam<int> {
  final NotificationRepository repository;

  GetUnreadNotificationUC({required this.repository});

  @override
  Future<Either<Failure, int>> call() async =>
      await repository.getUnreadNotification();
}
