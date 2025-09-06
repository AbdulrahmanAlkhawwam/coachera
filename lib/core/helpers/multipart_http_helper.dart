import 'dart:developer' as dev;
import 'dart:io';

import 'package:http/http.dart';

import '../constants/strings.dart';
import 'storage_helper.dart';

abstract class MultipartHttpHelper {
  Future<Response> postFile(
    String path, {
    required File file,
    required String fileField,
    Map<String, String>? fields,
    Map<String, String>? headers,
  });
}

class MultipartHttpHelperImpl extends MultipartHttpHelper {
  final String host;
  final String basePath;
  final StorageHelper storage;

  MultipartHttpHelperImpl({
    required this.host,
    required this.basePath,
    required this.storage,
  });

  @override
  Future<Response> postFile(
    String path, {
    required File file,
    required String fileField,
    Map<String, String>? fields,
    Map<String, String>? headers,
  }) async {
    final uri = _makeUri(path);
    final request = MultipartRequest("POST", uri);
    request.files.add(
      await MultipartFile.fromPath(
        fileField,
        file.path,
      ),
    );
    request.fields.addAll(fields ?? {});
    request.headers.addAll(_makeHeaders(extraHeaders: headers));
    dev.log(uri.toString(), name: "HttpHelper.postFile");
    dev.log(request.files.map((e) => e.field).toString(),
        name: "HttpHelper.postFile.files");
    dev.log(request.headers.toString(), name: "HttpHelper.postFile.headers");
    dev.log(request.fields.toString(), name: "HttpHelper.postFile.fields");
    final responseStream = await request.send();
    final response = await Response.fromStream(responseStream);
    dev.log(
      response.body,
      name: "HttpHelper.postFile.response",
    );
    return response;
  }

  Uri _makeUri(String path, {Map<String, dynamic>? queryParameters}) =>
      Uri.http(host, [basePath, path].join(), queryParameters);

  Map<String, String> _makeHeaders({
    Map? extraHeaders,
  }) {
    return {
      "Accept": "application/json",
      "Content-Type": "multipart/form-data",
      if (token.isNotEmpty) "Authorization": "Bearer $token",
      ...?extraHeaders,
    };
  }

  String get token {
    return storage.getString(accessTokenKey) ?? "";
  }
}
