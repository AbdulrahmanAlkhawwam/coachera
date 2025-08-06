import 'package:coachera/core/constants/routes.dart';

import '../../../../core/helpers/http/http_service.dart';
import '../model/organization_model.dart';

// import '../../../home/data/models/user_model.dart';

abstract class OrganizationRemoteDataSource {
  // Future <CourseModel> getCourse ({int id});

  Future<OrganizationModel> getOrganization(int id);
}

class OrganizationRemoteDataSourceImpl extends OrganizationRemoteDataSource {
  final HttpService http;

  OrganizationRemoteDataSourceImpl({required this.http});

  // @override
  // Future<List<OrganizationModel>> getCategories({int? page}) async {
  //   final response = await http.handleApiCall(
  //     () async => await http.get(
  //       Endpoint.categories,
  //       queryParameters: {
  //         "page": page.toString(),
  //         "size": 10.toString(),
  //         "sortBy": "id",
  //         "sortDirection": "desc"
  //       },
  //     ),
  //   );
  //   final List<dynamic> content = response.data['content'];
  //   return content.map((e) => CategoryModel.fromJson(e)).toList();
  // }

  @override
  Future<OrganizationModel> getOrganization(int id) async {
    final response = await http.handleApiCall(
      () async => await http.get(Endpoint.getOrganization(id)),
    ) as Map<String, dynamic>;
    final organization = response['data'];
    return OrganizationModel.fromJson(organization);
  }
}
