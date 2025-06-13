import '../localization/keys.g.dart';
import 'failures.dart';

final failureMessage = {
  NetworkFailure: LocaleKeys.error_messages_no_internet_connection,
  BadRequestFailure: LocaleKeys.error_messages_check_input_info,
  UnauthorizedFailure: LocaleKeys.error_messages_wrong_password_retry,
  PaymentRequiredFailure: LocaleKeys.error_messages_payment_required,
  ForbiddenFailure: LocaleKeys.error_messages_no_access_permission,
  DataNotFoundFailure: LocaleKeys.error_messages_resource_not_found,
  MethodNotAllowedFailure: LocaleKeys.error_messages_method_not_allowed,
  ConflictFailure: LocaleKeys.error_messages_conflict,
  GoneFailure: LocaleKeys.error_messages_gone,
  PreconditionFailedFailure: LocaleKeys.error_messages_precondition_failed,
  TooManyRequestsFailure: LocaleKeys.error_messages_exceeded_limit_retry_later,
  HttpRedirectionFailure: LocaleKeys.error_messages_redirection,
};