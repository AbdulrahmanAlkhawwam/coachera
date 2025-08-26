import '../../../../core/constants/routes.dart';
import '../../../../core/helpers/http/http_service.dart';
import '../model/organization_model.dart';

abstract class OrganizationRemoteDataSource {
  Future<OrganizationModel> getOrganization(int id);
}

class OrganizationRemoteDataSourceImpl extends OrganizationRemoteDataSource {
  final HttpService http;

  OrganizationRemoteDataSourceImpl({required this.http});

  @override
  Future<OrganizationModel> getOrganization(int id) async {
    final response = await http.handleApiCall(
      () async => await http.get(Endpoint.getOrganization(id)),
    );
    final organization = response.data;
    return OrganizationModel.fromJson(organization);
  }
}
