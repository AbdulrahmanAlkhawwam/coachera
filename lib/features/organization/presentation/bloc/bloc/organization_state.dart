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
  final int page;

  final List<Organization> organizations;

  const OrganizationState({
    this.status = OrganizationStatus.init,
    this.message,
    this.organization,
    this.page = 0,
    this.organizations = const [],
  });

  OrganizationState copyWith({
    OrganizationStatus? status,
    Message? message,
    Organization? organization,
    int? page,
    List<Organization>? organizations,
  }) =>
      OrganizationState(
        status: status ?? this.status,
        message: message ?? this.message,
        page: page ?? this.page,
        organization: organization ?? this.organization,
        organizations: organizations ?? this.organizations,
      );
}
