part of 'organization_bloc.dart';

enum OrganizationStatus {
  init,
  loading,
  error,
  success,
}

@immutable
class OrganizationState {
  final OrganizationStatus status;
  final Message? message;
  final Organization? organization;

  const OrganizationState({
    this.status = OrganizationStatus.init,
    this.message,
    this.organization,
  });

  OrganizationState copyWith({
    OrganizationStatus? status,
    Message? message,
    Organization? organization,
  }) =>
      OrganizationState(
        status: status ?? this.status,
        message: message ?? this.message,
        organization: organization ?? this.organization,
      );
}
