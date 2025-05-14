// 🔌 Network
class NoInternetException implements Exception {}

class TimeoutException implements Exception {}

// 🌐 HTTP
class HttpException implements Exception {
  final String message;
  final int statusCode;

  const HttpException(this.message, this.statusCode);
}

class BadRequestException implements Exception {}

class UnauthorizedException implements Exception {}

class PaymentRequiredException implements Exception {}

class ForbiddenException implements Exception {}

class DataNotFoundException implements Exception {}

class MethodNotAllowedException implements Exception {}

class ConflictException implements Exception {}

class GoneException implements Exception {}

class PreconditionFailedException implements Exception {}

class TooManyRequestsException implements Exception {}

class HttpRedirectionException implements Exception {
  final String message;
  final int statusCode;
  final Uri? redirectUri;

  HttpRedirectionException(this.statusCode, this.message, [this.redirectUri]);
}

class ServerException implements Exception {
  final int? statusCode;
  final String massage;

  const ServerException(this.statusCode, this.massage);
}

// 💾 Cache / Offline
class CacheReadException implements Exception {}

class CacheWriteException implements Exception {}

class OfflineSyncException implements Exception {}

// 📥 Download
class DownloadFailedException implements Exception {}

class InsufficientStorageException implements Exception {}

class FileAccessDeniedException implements Exception {}

// 🔐 Auth
class LoginFailedException implements Exception {}

class TokenExpiredException implements Exception {}

class UserNotFoundException implements Exception {}

// 🧑‍🏫 Domain
class OrganizationNotFoundException implements Exception {}

class StudentAlreadyExistsException implements Exception {}

class EnrollmentFailedException implements Exception {}

class AlreadyEnrolledException implements Exception {}

class CourseNotFoundException implements Exception {}
