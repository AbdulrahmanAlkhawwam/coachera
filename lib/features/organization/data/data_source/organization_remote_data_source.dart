import '../../../../core/constants/routes.dart';
import '../../../../core/constants/strings.dart';
import '../../../../core/helpers/http/http_service.dart';
import '../../../home/domain/param/list_param.dart';
import '../model/organization_model.dart';

abstract class OrganizationRemoteDataSource {
  Future<List<OrganizationModel>> getOrganizations(ListParam param);

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

  @override
  Future<List<OrganizationModel>> getOrganizations(ListParam param) async {
    final response = await http.handleApiCall(() async => await http.get(
          Endpoint.getOrganizations,
          queryParameters: {
            "page": param.page.toString(),
            "size": pageSize.toString(),
            if (param.sort.sortBy != null) "sortBy": param.sort.sortBy!,
            if (param.sort.sortDirection != null)
              "sortDirection": param.sort.sortDirection!,
          },
        ));

    final List<dynamic> organizations = response.data["content"];

    return organizations.map((e) => OrganizationModel.fromJson(e)).toList();
  }
}
