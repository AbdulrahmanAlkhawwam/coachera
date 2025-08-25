import '../../../../core/constants/routes.dart';
import '../../../../core/helpers/http/http_service.dart';
import '../model/review_model.dart';

abstract class ReviewRemoteDataSource {
  Future<List<ReviewModel>> getCourseReview(int id);

  Future<List<ReviewModel>> getReviews();
}

class ReviewRemoteDataSourceImpl extends ReviewRemoteDataSource {
  final HttpService http;

  ReviewRemoteDataSourceImpl({required this.http});

  @override
  Future<List<ReviewModel>> getReviews() async {
    final response =
        await http.handleApiCall(() async => await http.get(Endpoint.reviews));
    final List<dynamic> reviews = response.data;
    return reviews.map((e) => ReviewModel.fromJson(e)).toList();
  }

  @override
  Future<List<ReviewModel>> getCourseReview(int id) async {
    final response = await http
        .handleApiCall(() async => await http.get(Endpoint.courseReviews(id)));

    final List<dynamic> reviews = response.data;
    return reviews.map((e) => ReviewModel.fromJson(e)).toList();
  }
}
