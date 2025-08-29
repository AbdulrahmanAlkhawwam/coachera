import 'package:easy_localization/easy_localization.dart';
import 'package:equatable/equatable.dart';

import '../error/failure_message.dart';
import '../error/failures.dart';
import '../localization/keys.g.dart';

class Message extends Equatable {
  final String? value;
  final int? code;
  final String? platformCode;
  final String? title;

  const Message({
    this.value,
    this.code,
    this.platformCode,
    this.title,
  });

  factory Message.fromFailure(Failure failure) {
    if (failure is ServerFailure) {
      return Message(code: failure.statusCode);
    }

    for (final entry in failureMessage.entries) {
      if (failure.runtimeType == entry.key) {
        return Message(
          title: entry.value['title']?.toString().tr(),
          value: entry.value['value']?.toString().tr(),
          code: int.parse(entry.value['statusCode']!.toString()),
        );
      }
    }

    return Message(
      title: LocaleKeys.errors_unknown_error_title.tr(),
      value: LocaleKeys.errors_unknown_error_message.tr(),
    );
  }

  String _getMessageFromPlatformCode() {
    switch (platformCode) {
      case "1":
        return LocaleKeys.errors_operation_cancelled_message.tr();
      case "3":
        return LocaleKeys.errors_purchase_failed_error_3_message.tr();
      case "7":
        return LocaleKeys.errors_cannot_restore_subscription_error_7_message
            .tr();
      case "10":
        return LocaleKeys.errors_network_error_retry_message.tr();
      default:
        return LocaleKeys.errors_operation_failed_with_code_args_message
            .tr(args: [platformCode!]);
    }
  }

  @override
  String toString() {
    if (value != null) return value!;
    if (platformCode != null) return _getMessageFromPlatformCode();
    return LocaleKeys.errors_unknown_error_message.tr();
  }

  @override
  List<Object?> get props => [value, code, title];
}
