import 'http_response.dart';

abstract class HttpClient {
  Future<HttpResponse> get(
    String path, {
    Map<String, String>? queryParameters,
    Map<String, String>? headers,
  });

  Future<HttpResponse> post(
    String path, {
    Map<String, String>? queryParameters,
    Map<String, dynamic>? body,
    Map<String, String>? headers,
  });

  Future<HttpResponse> put(
    String path, {
    Map<String, String>? queryParameters,
    Map<String, dynamic>? body,
    Map<String, String>? headers,
  });

  Future<HttpResponse> patch(
    String path, {
    Map<String, String>? queryParameters,
    Map<String, dynamic>? body,
    Map<String, String>? headers,
  });

  Future<HttpResponse> delete(
    String path, {
    Map<String, String>? queryParameters,
    Map<String, dynamic>? body,
    Map<String, String>? headers,
  });

  Future<T> handleApiCall<T>(Future<T> Function() call);

  Uri makeUri(String path, {Map<String, String>? queryParameters});

  Future<void> close();
}
