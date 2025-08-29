import '../localization/keys.g.dart';
import 'failures.dart';

final failureMessage = {
  NetworkFailure: {
    "statusCode": null,
    "title": LocaleKeys.errors_no_internet_connection_title,
    "value": LocaleKeys.errors_no_internet_connection_message,
  },
  BadRequestFailure: {
    "statusCode": 400,
    "title": LocaleKeys.errors_check_input_info_title,
    "value": LocaleKeys.errors_check_input_info_message,
  },
  UnauthorizedFailure: {
    "statusCode": 401,
    "title": LocaleKeys.errors_wrong_password_retry_title,
    "value": LocaleKeys.errors_wrong_password_retry_message,
  },
  PaymentRequiredFailure: {
    "statusCode": 402,
    "title": LocaleKeys.errors_payment_required_title,
    "value": LocaleKeys.errors_payment_required_message,
  },
  ForbiddenFailure: {
    "statusCode": 403,
    "title": LocaleKeys.errors_no_access_permission_title,
    "value": LocaleKeys.errors_no_access_permission_message,
  },
  DataNotFoundFailure: {
    "statusCode": 404,
    "title": LocaleKeys.errors_resource_not_found_title,
    "value": LocaleKeys.errors_resource_not_found_message,
  },
  MethodNotAllowedFailure: {
    "statusCode": 405,
    "title": LocaleKeys.errors_method_not_allowed_title,
    "value": LocaleKeys.errors_method_not_allowed_message,
  },
  ConflictFailure: {
    "statusCode": 409,
    "title": LocaleKeys.errors_conflict_title,
    "value": LocaleKeys.errors_conflict_message,
  },
  GoneFailure: {
    "statusCode": 410,
    "title": LocaleKeys.errors_gone_title,
    "value": LocaleKeys.errors_gone_message,
  },
  PreconditionFailedFailure: {
    "statusCode": 412,
    "title": LocaleKeys.errors_precondition_failed_title,
    "value": LocaleKeys.errors_precondition_failed_message,
  },
  TooManyRequestsFailure: {
    "statusCode": 429,
    "title": LocaleKeys.errors_exceeded_limit_retry_later_title,
    "value": LocaleKeys.errors_exceeded_limit_retry_later_message,
  },
  HttpRedirectionFailure: {
    "statusCode": 302,
    "title": LocaleKeys.errors_redirection_title,
    "value": LocaleKeys.errors_redirection_message,
  },
};
