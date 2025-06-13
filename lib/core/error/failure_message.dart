import '../localization/keys.g.dart';
import 'failures.dart';

final failureMessage = {
  NetworkFailure: {
    "title": LocaleKeys.errors_no_internet_connection_title,
    "value": LocaleKeys.errors_no_internet_connection_message,
  },
  BadRequestFailure: {
    "title": LocaleKeys.errors_check_input_info_title,
    "value": LocaleKeys.errors_check_input_info_message,
  },
  UnauthorizedFailure: {
    "title": LocaleKeys.errors_wrong_password_retry_title,
    "value": LocaleKeys.errors_wrong_password_retry_message,
  },
  PaymentRequiredFailure: {
    "title": LocaleKeys.errors_payment_required_title,
    "value": LocaleKeys.errors_payment_required_message,
  },
  ForbiddenFailure: {
    "title": LocaleKeys.errors_no_access_permission_title,
    "value": LocaleKeys.errors_no_access_permission_message,
  },
  DataNotFoundFailure: {
    "title": LocaleKeys.errors_resource_not_found_title,
    "value": LocaleKeys.errors_resource_not_found_message,
  },
  MethodNotAllowedFailure: {
    "title": LocaleKeys.errors_method_not_allowed_title,
    "value": LocaleKeys.errors_method_not_allowed_message,
  },
  ConflictFailure: {
    "title": LocaleKeys.errors_conflict_title,
    "value": LocaleKeys.errors_conflict_message,
  },
  GoneFailure: {
    "title": LocaleKeys.errors_gone_title,
    "value": LocaleKeys.errors_gone_message,
  },
  PreconditionFailedFailure: {
    "title": LocaleKeys.errors_precondition_failed_title,
    "value": LocaleKeys.errors_precondition_failed_message,
  },
  TooManyRequestsFailure: {
    "title": LocaleKeys.errors_exceeded_limit_retry_later_title,
    "value": LocaleKeys.errors_exceeded_limit_retry_later_message,
  },
  HttpRedirectionFailure: {
    "title": LocaleKeys.errors_redirection_title,
    "value": LocaleKeys.errors_redirection_message,
  },
};
