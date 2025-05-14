class HttpResponse {
  final dynamic data;
  final int statusCode;
  final Map<String, String> headers;

  HttpResponse({
    required this.data,
    required this.statusCode,
    required this.headers,
  });
}