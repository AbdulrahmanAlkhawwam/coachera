import '../../../../core/constants/routes.dart';
import '../../../../core/helpers/http/http_service.dart';
import '../../../course/data/model/course_model.dart';

abstract class FavoriteRemoteDataSource {
  Future<List<CourseModel>> getFavorite();

  Future<void> addFavorite(int courseId);

  Future<void> removeFavorite(int courseId);
}

class FavoriteRemoteDataSourceImpl extends FavoriteRemoteDataSource {
  final HttpService http;

  FavoriteRemoteDataSourceImpl({required this.http});

  @override
  Future<List<CourseModel>> getFavorite() async {
    final response = await http
        .handleApiCall(() async => await http.get(Endpoint.getFavorites));
    // todo : fix this data when it empty
    final List<dynamic> courses = response.data?['data'];
    return courses.map((e) => CourseModel.fromJson(e)).toList();
  }

  @override
  Future<void> addFavorite(int courseId) async {
    await http.handleApiCall(
        () async => await http.post(Endpoint.addFavorite(courseId)));
  }

  @override
  Future<void> removeFavorite(int courseId) async {
    await http.handleApiCall(
        () async => await http.post(Endpoint.removeFavorite(courseId)));
  }
}
