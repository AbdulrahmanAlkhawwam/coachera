import '../../../../core/constants/routes.dart';
import '../../../../core/helpers/http/http_service.dart';
import '../../../course/data/model/course_model.dart';

abstract class FavoriteRemoteDataSource {
  Future<List<CourseModel>> getFavorites();

  Future<void> addFavorite(int courseId);

  Future<void> removeFavorite(int courseId);

  Future<bool> getFavorite(int courseId);
}

class FavoriteRemoteDataSourceImpl extends FavoriteRemoteDataSource {
  final HttpService http;

  FavoriteRemoteDataSourceImpl({required this.http});

  @override
  Future<List<CourseModel>> getFavorites() async {
    final response = await http
        .handleApiCall(() async => await http.get(Endpoint.getFavorites));
    final List<dynamic> courses = response.data;
    // todo : wait the backend to change the bug (DTO String here)
    return courses.map((e) => CourseModel.fromJson(e)).toList();
  }

  @override
  Future<void> addFavorite(int courseId) async {
    final response = await http.handleApiCall(
        () async => await http.post(Endpoint.addFavorite(courseId)));
    print(response.toString());
  }

  @override
  Future<void> removeFavorite(int courseId) async {
    await http.handleApiCall(
        () async => await http.delete(Endpoint.deleteFavorite(courseId)));
  }

  @override
  Future<bool> getFavorite(int courseId) async {
    final response = await http.handleApiCall(
        () async => await http.get(Endpoint.getFavorite(courseId)));
    return response.data;
  }
}
