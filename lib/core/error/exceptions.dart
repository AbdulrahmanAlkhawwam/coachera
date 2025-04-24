// Network Exception
class NoInternetException implements Exception {}

class TimeoutException implements Exception {}

class BadRequestException implements Exception {}

class UnauthorizedException implements Exception {}

class ServerException implements Exception {
  final int? statusCode;

  const ServerException([this.statusCode]);
}

// Cache/Offline Exception
class CacheReadException implements Exception {}

class CacheWriteException implements Exception {}

class DataNotFoundException implements Exception {}

class OfflineSyncException implements Exception {}

// Download Exception
class DownloadFailedException implements Exception {}

class InsufficientStorageException implements Exception {}

class FileAccessDeniedException implements Exception {}

// Authentication / Authorization Exception
class LoginFailedException implements Exception {}

class TokenExpiredException implements Exception {}

class UserNotFoundException implements Exception {}

// Domain Exceptions
// Organization / Student
class OrganizationNotFoundException implements Exception {}

class StudentAlreadyExistsException implements Exception {}

// Enrolling
class EnrollmentFailedException implements Exception {}

class AlreadyEnrolledException implements Exception {}

class CourseNotFoundException implements Exception {}
