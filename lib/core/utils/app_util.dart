import 'dart:developer' as dev;
import 'package:dartz/dartz.dart';

import '../error/exceptions.dart';
import '../error/failures.dart';

class AppUtils {
  AppUtils._();

  static Future<Either<Failure, T>> safeCall<T>(
      Future<T> Function() call,
      ) async {
    try {
      return Right(await call());
    } on NoInternetException catch (e, s) {
      dev.log(e.runtimeType.toString(), error: e, stackTrace: s);
      return const Left(NetworkFailure());
    } on TimeoutException catch (e, s) {
      dev.log(e.runtimeType.toString(), error: e, stackTrace: s);
      return const Left(TimeoutFailure());
    } on HttpException catch (e, s) {
      dev.log(e.runtimeType.toString(), error: e, stackTrace: s);
      return Left(ServerFailure(e.statusCode));
    } on BadRequestException catch (e, s) {
      dev.log(e.runtimeType.toString(), error: e, stackTrace: s);
      return const Left(BadRequestFailure());
    } on UnauthorizedException catch (e, s) {
      dev.log(e.runtimeType.toString(), error: e, stackTrace: s);
      return const Left(UnauthorizedFailure());
    } on PaymentRequiredException catch (e, s) {
      dev.log(e.runtimeType.toString(), error: e, stackTrace: s);
      return const Left(PaymentRequiredFailure());
    } on ForbiddenException catch (e, s) {
      dev.log(e.runtimeType.toString(), error: e, stackTrace: s);
      return const Left(ForbiddenFailure());
    } on MethodNotAllowedException catch (e, s) {
      dev.log(e.runtimeType.toString(), error: e, stackTrace: s);
      return const Left(MethodNotAllowedFailure());
    } on ConflictException catch (e, s) {
      dev.log(e.runtimeType.toString(), error: e, stackTrace: s);
      return const Left(ConflictFailure());
    } on GoneException catch (e, s) {
      dev.log(e.runtimeType.toString(), error: e, stackTrace: s);
      return const Left(GoneFailure());
    } on PreconditionFailedException catch (e, s) {
      dev.log(e.runtimeType.toString(), error: e, stackTrace: s);
      return const Left(PreconditionFailedFailure());
    } on TooManyRequestsException catch (e, s) {
      dev.log(e.runtimeType.toString(), error: e, stackTrace: s);
      return const Left(TooManyRequestsFailure());
    } on HttpRedirectionException catch (e, s) {
      dev.log(e.runtimeType.toString(), error: e, stackTrace: s);
      return Left(HttpRedirectionFailure(e.redirectUri));
    } on ServerException catch (e, s) {
      dev.log(e.runtimeType.toString(), error: e, stackTrace: s);
      return Left(ServerFailure(e.statusCode));
    } on CacheReadException catch (e, s) {
      dev.log(e.runtimeType.toString(), error: e, stackTrace: s);
      return const Left(CacheReadFailure());
    } on CacheWriteException catch (e, s) {
      dev.log(e.runtimeType.toString(), error: e, stackTrace: s);
      return const Left(CacheWriteFailure());
    } on OfflineSyncException catch (e, s) {
      dev.log(e.runtimeType.toString(), error: e, stackTrace: s);
      return const Left(OfflineSyncFailure());
    } on DownloadFailedException catch (e, s) {
      dev.log(e.runtimeType.toString(), error: e, stackTrace: s);
      return const Left(DownloadFailure());
    } on InsufficientStorageException catch (e, s) {
      dev.log(e.runtimeType.toString(), error: e, stackTrace: s);
      return const Left(InsufficientStorageFailure());
    } on FileAccessDeniedException catch (e, s) {
      dev.log(e.runtimeType.toString(), error: e, stackTrace: s);
      return const Left(FileAccessDeniedFailure());
    } on LoginFailedException catch (e, s) {
      dev.log(e.runtimeType.toString(), error: e, stackTrace: s);
      return const Left(LoginFailure());
    } on TokenExpiredException catch (e, s) {
      dev.log(e.runtimeType.toString(), error: e, stackTrace: s);
      return const Left(TokenExpiredFailure());
    } on UserNotFoundException catch (e, s) {
      dev.log(e.runtimeType.toString(), error: e, stackTrace: s);
      return const Left(UserNotFoundFailure());
    } on OrganizationNotFoundException catch (e, s) {
      dev.log(e.runtimeType.toString(), error: e, stackTrace: s);
      return const Left(OrganizationNotFoundFailure());
    } on StudentAlreadyExistsException catch (e, s) {
      dev.log(e.runtimeType.toString(), error: e, stackTrace: s);
      return const Left(StudentAlreadyExistsFailure());
    } on EnrollmentFailedException catch (e, s) {
      dev.log(e.runtimeType.toString(), error: e, stackTrace: s);
      return const Left(EnrollmentFailure());
    } on AlreadyEnrolledException catch (e, s) {
      dev.log(e.runtimeType.toString(), error: e, stackTrace: s);
      return const Left(AlreadyEnrolledFailure());
    } on CourseNotFoundException catch (e, s) {
      dev.log(e.runtimeType.toString(), error: e, stackTrace: s);
      return const Left(CourseNotFoundFailure());
    } on DataNotFoundException catch (e, s) {
      dev.log(e.runtimeType.toString(), error: e, stackTrace: s);
      return const Left(DataNotFoundFailure());
    } catch (e, s) {
      dev.log(e.runtimeType.toString(), error: e, stackTrace: s);
      return const Left(UnexpectedFailure());
    }
  }
}
