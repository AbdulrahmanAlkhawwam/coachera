part of 'organization_bloc.dart';

@immutable
sealed class OrganizationEvent {}

class GetOrganization extends OrganizationEvent {
  final int orgId;

  GetOrganization({required this.orgId});
}
