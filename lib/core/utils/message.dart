import 'package:coachera/core/error/failure_message.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:equatable/equatable.dart';

import '../error/failures.dart';
import '../localization/keys.g.dart';

class Message extends Equatable {
  final String? value;
  final int? code;
  final String? platformCode;
  // final bool readable;

  const Message({
    this.value,
    this.code,
    this.platformCode,
    // this.readable = false,
  });

  factory Message.fromFailure(Failure failure) {
    if (failure is ServerFailure) {
      return Message(code: failure.statusCode);
    }

    for (final entry in failureMessage.entries) {
      if (failure.runtimeType == entry.key) {
        return Message(value: entry.value.tr());
      }
    }

    return Message(value: LocaleKeys.error_messages_unknown_error.tr());
  }

  String _getMessageFromPlatformCode() {
    switch (platformCode) {
      case "1":
        return LocaleKeys.error_messages_operation_cancelled.tr();
      case "3":
        return LocaleKeys.error_messages_purchase_failed_error_3.tr();
      case "7":
        return LocaleKeys.error_messages_cannot_restore_subscription_error_7
            .tr();
      case "10":
        return LocaleKeys.error_messages_network_error_retry.tr();
      default:
        return LocaleKeys.error_messages_operation_failed_with_code_args
            .tr(args: [platformCode!]);
    }
  }

  @override
  String toString() {
    if (/*readable &&*/ value != null) return value!;
    if (platformCode != null) return _getMessageFromPlatformCode();
    return LocaleKeys.error_messages_unknown.tr();
  }

  @override
  List<Object?> get props => [value, code/*, readable*/];
}
