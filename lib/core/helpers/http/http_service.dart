import 'dart:async';
import 'dart:convert';
import 'dart:developer' as dev;
import 'package:http/http.dart' as http;

import '../../error/exceptions.dart';
import '../storage_helper.dart';
import 'http_client.dart';
import 'http_response.dart';

enum _RequestMethod { get, post, put, patch, delete }

class HttpService implements HttpClient {
  final String host;
  final String basePath;
  final http.Client client;
  final StorageHelper storage;
  final Duration timeout;
  bool? connectivityService;

  HttpService({
    required this.host,
    required this.basePath,
    required this.client,
    required this.storage,
    this.connectivityService,
    this.timeout = const Duration(seconds: 20),
  });

  @override
  Future<HttpResponse> get(
    String path, {
    Map<String, String>? queryParameters,
    Map<String, String>? headers,
  }) =>
      _sendRequest(_RequestMethod.get, path,
          queryParameters: queryParameters, headers: headers);

  @override
  Future<HttpResponse> post(
    String path, {
    Map<String, String>? queryParameters,
    dynamic body,
    Map<String, String>? headers,
  }) =>
      _sendRequest(_RequestMethod.post, path,
          queryParameters: queryParameters, body: body, headers: headers);

  @override
  Future<HttpResponse> put(
    String path, {
    Map<String, String>? queryParameters,
    Map<String, dynamic>? body,
    Map<String, String>? headers,
  }) =>
      _sendRequest(_RequestMethod.put, path,
          queryParameters: queryParameters, body: body, headers: headers);

  @override
  Future<HttpResponse> patch(
    String path, {
    Map<String, String>? queryParameters,
    Map<String, dynamic>? body,
    Map<String, String>? headers,
  }) =>
      _sendRequest(_RequestMethod.patch, path,
          queryParameters: queryParameters, body: body, headers: headers);

  @override
  Future<HttpResponse> delete(
    String path, {
    Map<String, String>? queryParameters,
    Map<String, dynamic>? body,
    Map<String, String>? headers,
  }) =>
      _sendRequest(_RequestMethod.delete, path,
          queryParameters: queryParameters, body: body, headers: headers);

  Future<HttpResponse> _sendRequest(
    _RequestMethod method,
    String path, {
    Map<String, String>? queryParameters,
    dynamic body,
    Map<String, String>? headers,
  }) async {
    if (connectivityService!) {
      throw NoInternetException();
    }

    try {
      final uri = makeUri(path, queryParameters: queryParameters);
      final requestHeaders = _makeHeaders(headers);
      final encodedBody = body != null ? jsonEncode(body) : body;
      _logRequest(method, uri, requestHeaders, body);
      final response = await _executeRequest(method, uri,
              headers: requestHeaders, body: encodedBody)
          .timeout(timeout);
      _logResponse(method, response);
      return _handleResponse(response);
      //socet exception
    } on TimeoutException {
      throw TimeoutException();
    } on http.ClientException catch (e) {
      throw ServerException(502, e.message);
    } catch (e) {
      dev.log('Unexpected error: $e', error: e, stackTrace: StackTrace.current);
      rethrow;
    }
  }

  Future<http.Response> _executeRequest(
    _RequestMethod method,
    Uri uri, {
    required Map<String, String> headers,
    String? body,
  }) async {
    switch (method) {
      case _RequestMethod.get:
        return client.get(uri, headers: headers);
      case _RequestMethod.post:
        return client.post(uri, headers: headers, body: body);
      case _RequestMethod.put:
        return client.put(uri, headers: headers, body: body);
      case _RequestMethod.patch:
        return client.patch(uri, headers: headers, body: body);
      case _RequestMethod.delete:
        return client.delete(uri, headers: headers, body: body);
    }
  }

  HttpResponse _handleResponse(http.Response response) {
    switch (response.statusCode) {
      case >= 200 && < 300:
        return HttpResponse(
          data: _parseResponseBody(response.body),
          statusCode: response.statusCode,
          headers: response.headers,
        );
      case 400:
        throw BadRequestException();
      case 401:
        throw UnauthorizedException();
      case 402:
        throw PaymentRequiredException();
      case 403:
        throw ForbiddenException();
      case 404:
        throw DataNotFoundException();
      case 405:
        throw MethodNotAllowedException();
      case 409:
        throw ConflictException();
      case 410:
        throw GoneException();
      case 412:
        throw PreconditionFailedException();
      case 429:
        throw TooManyRequestsException();
      case >= 500 && < 600:
        throw ServerException(response.statusCode, response.body);
      case >= 300 && < 400:
        final location = response.headers['location'];
        throw HttpRedirectionException(
          response.statusCode,
          'Request was redirected',
          location != null ? Uri.tryParse(location) : null,
        );

      default:
        throw HttpException(
          'Received unexpected status code: ${response.statusCode}',
          response.statusCode,
        );
    }
  }

  @override
  Future<T> handleApiCall<T>(Future<T> Function() call) async {
    try {
      return await call();
    } catch (e) {
      rethrow;
    }
  }

  dynamic _parseResponseBody(String body) {
    try {
      return jsonDecode(body);
    } catch (_) {
      return body.isNotEmpty ? body : null;
    }
  }

  Map<String, String> _makeHeaders([Map? extraHeaders]) {
    return {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      if (token.isNotEmpty) 'Authorization': 'Bearer $token',
      ...?extraHeaders,
    };
  }

  @override
  Uri makeUri(String path, {Map<String, String>? queryParameters}) {
    return Uri.http(host, '$basePath$path', queryParameters);
  }

  void _logRequest(_RequestMethod method, Uri uri, Map<String, String> headers,
      dynamic body) {
    final safeHeaders = Map<String, String>.from(headers);
    // line for delete token (high security)
    if (safeHeaders.containsKey('Authorization')) {
      // safeHeaders['Authorization'] = 'Bearer [REDACTED]';
    }

    dev.log(
      '[${method.name.toUpperCase()}] ${uri.toString()}',
      name: 'HTTP Request',
    );
    dev.log('[${method.name.toUpperCase()}].Headers: $safeHeaders',
        name: 'HTTP Request');
    if (body != null) {
      dev.log('[${method.name.toUpperCase()}].Body: $body',
          name: 'HTTP Request');
    }
  }

  void _logResponse(_RequestMethod method, http.Response response) {
    dev.log(
      '[${method.name.toUpperCase()}] Status: ${response.statusCode}',
      name: 'HTTP Response',
    );
    dev.log(
      'Response: ${response.body.length > 200 ? '${response.body.substring(0, 200)}...' : response.body}',
      name: 'HTTP Response',
    );
  }

  @override
  Future<void> close() async {
    client.close();
  }

  String get token {
    return '';
  }
}
