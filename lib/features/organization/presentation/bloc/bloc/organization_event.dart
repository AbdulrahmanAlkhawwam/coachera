part of 'organization_bloc.dart';

@immutable
sealed class OrganizationEvent {}

class GetOrganization extends OrganizationEvent {
  final int orgId;

  GetOrganization({required this.orgId});
}

class GetOrganizations extends OrganizationEvent{
  final ListParam param ;

  GetOrganizations({required this.param});
}
