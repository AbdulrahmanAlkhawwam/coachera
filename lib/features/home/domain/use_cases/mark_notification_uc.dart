import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../repositories/favorite_repository.dart';
import '../repositories/notification_repository.dart';

class MarkNotificationUC extends UseCase<void,int> {
  final NotificationRepository repository;

  MarkNotificationUC({required this.repository});

  @override
  Future<Either<Failure, void>> call(ids) async =>
      await repository.markNotifications(ids);
}
