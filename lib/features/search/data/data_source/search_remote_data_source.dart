import '../../../../core/constants/routes.dart';
import '../../../../core/helpers/http/http_service.dart';
import '../../domain/entities/entity.dart';

abstract class SearchRemoteDataSource {
  Future<List<Entity>> getEntities();
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
}
