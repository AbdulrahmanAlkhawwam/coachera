import '../../../../core/constants/routes.dart';
import '../../../../core/helpers/http/http_service.dart';
import '../model/module_model.dart';

abstract class ModuleRemoteDataSource {
  Future<List<ModuleModel>> getCourseModules({int? courseId});
}

class ModuleRemoteDataSourceImpl extends ModuleRemoteDataSource {
  final HttpService http;

  ModuleRemoteDataSourceImpl({required this.http});

  @override
  Future<List<ModuleModel>> getCourseModules({int? courseId}) async {
    final response = await http.handleApiCall(
        () async => await http.get(Endpoint.courseModules(courseId)));

    final List<dynamic> modules = response.data;
    return modules.map((e) => ModuleModel.fromJson(e)).toList();
  }
}
