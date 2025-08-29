import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../../../core/utils/message.dart';
import '../../../../home/domain/param/list_param.dart';
import '../../../domain/entities/organization.dart';
import '../../../domain/use_cases/get_organization_uc.dart';
import '../../../domain/use_cases/get_organizations_uc.dart';

part 'organization_event.dart';

part 'organization_state.dart';

class OrganizationBloc extends Bloc<OrganizationEvent, OrganizationState> {
  final GetOrganizationUC getOrganizationUc;
  final GetOrganizationsUC getOrganizationsUC;

  OrganizationBloc({
    required this.getOrganizationUc,
    required this.getOrganizationsUC,
  }) : super(OrganizationState()) {
    on<GetOrganization>(_getOrganization);
    on<GetOrganizations>(_getOrganizations);
  }

  FutureOr<void> _getOrganization(
      GetOrganization event, Emitter<OrganizationState> emit) async {
    emit(state.copyWith(status: OrganizationStatus.loading));
    final response = await getOrganizationUc.call(event.orgId);
    response.fold(
      (failure) => emit(state.copyWith(
        status: OrganizationStatus.error,
        message: Message.fromFailure(failure),
      )),
      (organization) => emit(state.copyWith(
        status: OrganizationStatus.success,
        organization: organization,
      )),
    );
  }

  FutureOr<void> _getOrganizations(
      GetOrganizations event, Emitter<OrganizationState> emit) async {
    emit(state.copyWith(status: OrganizationStatus.loading));
    if (event.param.page == 0) {
      emit(state.copyWith(organizations: []));
    }
    final response = await getOrganizationsUC(event.param);
    response.fold(
      (failure) => emit(state.copyWith(
        status: OrganizationStatus.error,
        message: Message.fromFailure(failure),
      )),
      (organizations) => emit(state.copyWith(
          status: OrganizationStatus.success,
          organizations: [...state.organizations, ...organizations],
          page: event.param.page)),
    );
  }
}
