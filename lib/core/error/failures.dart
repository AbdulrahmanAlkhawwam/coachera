abstract class Failure {
  const Failure();
}

// 🔌 Network
class NetworkFailure extends Failure {
  const NetworkFailure();
}

class TimeoutFailure extends Failure {
  const TimeoutFailure();
}

// 🌐 HTTP
class ServerFailure extends Failure {
  final int? statusCode;

  const ServerFailure([this.statusCode]);
}

class UnauthorizedFailure extends Failure {
  const UnauthorizedFailure();
}

class BadRequestFailure extends Failure {
  const BadRequestFailure();
}

class PaymentRequiredFailure extends Failure {
  const PaymentRequiredFailure();
}

class ForbiddenFailure extends Failure {
  const ForbiddenFailure();
}

class MethodNotAllowedFailure extends Failure {
  const MethodNotAllowedFailure();
}

class ConflictFailure extends Failure {
  const ConflictFailure();
}

class GoneFailure extends Failure {
  const GoneFailure();
}

class PreconditionFailedFailure extends Failure {
  const PreconditionFailedFailure();
}

class TooManyRequestsFailure extends Failure {
  const TooManyRequestsFailure();
}

class HttpRedirectionFailure extends Failure {
  final Uri? redirectUri;

  const HttpRedirectionFailure([this.redirectUri]);
}

class InternalServerErrorFailure extends Failure {
  const InternalServerErrorFailure();
}

// 💾 Cache / Offline
class CacheReadFailure extends Failure {
  const CacheReadFailure();
}

class CacheWriteFailure extends Failure {
  const CacheWriteFailure();
}

class OfflineSyncFailure extends Failure {
  const OfflineSyncFailure();
}

// 📥 Download
class DownloadFailure extends Failure {
  const DownloadFailure();
}

class InsufficientStorageFailure extends Failure {
  const InsufficientStorageFailure();
}

class FileAccessDeniedFailure extends Failure {
  const FileAccessDeniedFailure();
}

// 🔐 Auth
class LoginFailure extends Failure {
  const LoginFailure();
}

class TokenExpiredFailure extends Failure {
  const TokenExpiredFailure();
}

class UserNotFoundFailure extends Failure {
  const UserNotFoundFailure();
}

// 🧑‍🏫 Domain
class OrganizationNotFoundFailure extends Failure {
  const OrganizationNotFoundFailure();
}

class StudentAlreadyExistsFailure extends Failure {
  const StudentAlreadyExistsFailure();
}

class EnrollmentFailure extends Failure {
  const EnrollmentFailure();
}

class AlreadyEnrolledFailure extends Failure {
  const AlreadyEnrolledFailure();
}

class CourseNotFoundFailure extends Failure {
  const CourseNotFoundFailure();
}

class DataNotFoundFailure extends Failure {
  const DataNotFoundFailure();
}

// ❓ Fallback
class UnexpectedFailure extends Failure {
  const UnexpectedFailure();
}
