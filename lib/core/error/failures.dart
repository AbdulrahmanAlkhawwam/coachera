abstract class Failure {
  const Failure();
}

class CacheFailure extends Failure {
  const CacheFailure();
}
class ServerFailure extends Failure {
  final int? statusCode;

  const ServerFailure([this.statusCode]);
}

class NetworkFailure extends Failure {}

class UnauthorizedFailure extends Failure {}

class TimeoutFailure extends Failure {}

class DownloadFailure extends Failure {}

class InsufficientStorageFailure extends Failure {}

class FileAccessDeniedFailure extends Failure {}

class LoginFailure extends Failure {}

class TokenExpiredFailure extends Failure {}

class UserNotFoundFailure extends Failure {}

class CourseNotFoundFailure extends Failure {}

class AlreadyEnrolledFailure extends Failure {}

class EnrollmentFailure extends Failure {}

class StudentAlreadyExistsFailure extends Failure {}

class OrganizationNotFoundFailure extends Failure {}

class DataNotFoundFailure extends Failure {}

class UnexpectedFailure extends Failure {}