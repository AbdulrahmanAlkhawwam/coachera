import '../../../../core/constants/routes.dart';
import '../../../../core/constants/strings.dart';
import '../../../../core/helpers/http/http_service.dart';
import '../../../category/data/model/category_model.dart';
import '../../../course/data/model/course_model.dart';
import '../../../instructor/data/model/instructor_model.dart';
import '../../../learningPath/data/model/learning_path_model.dart';
import '../../../material/data/model/material_model.dart';
import '../../../review/data/model/review_model.dart';
import '../../domain/entities/entity.dart';
import '../../domain/params/search_param.dart';

abstract class SearchRemoteDataSource {
  Future<List<Entity>> getEntities();

  Future<List<dynamic>> search(SearchParam param);
}

class SearchRemoteDataSourceImpl extends SearchRemoteDataSource {
  final HttpService http;

  SearchRemoteDataSourceImpl({required this.http});

  @override
  Future<List<Entity>> getEntities() async {
    final response = await http
        .handleApiCall(() async => await http.get(Endpoint.getEntities));
    return (response.data as List).map((e) => Entity(name: e, id: e)).toList();
  }

  @override
  Future<List<dynamic>> search(SearchParam param) async {
    final response = await http.handleApiCall(() async => await http.post(
          Endpoint.search(param.entity.name),
          body: {
            "page": param.param.page.toString(),
            "size": pageSize.toString(),
            if (param.param.sort.sortBy != null)
              "sortBy": param.param.sort.sortBy!,
            if (param.param.sort.sortDirection != null)
              "sortDirection": param.param.sort.sortDirection!,
            "searchTerm": param.input,
          },
        ));

    final List<dynamic> data = response.data["content"];
    return data
        .map((e) => switch (param.entity.name) {
              "courses" => CourseModel.fromJson(e),
              "reviews" => ReviewModel.fromJson(e),
              "instructors" => InstructorModel.fromJson(e),
              "learning-paths" => LearningPathModel.fromJson(e),
              "materials" => MaterialModel.fromJson(e),
              "categories" => CategoryModel.fromJson(e),
              _ => e,
            })
        .toList();
  }
}
