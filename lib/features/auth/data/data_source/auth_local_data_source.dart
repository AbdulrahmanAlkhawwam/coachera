import '../../../../core/constants/strings.dart';
import '../../../../core/helpers/storage_helper.dart';

abstract class AuthLocalDataSource {
  Future<void> removeToken();

  Future<void> saveToken(String token);
}

class AuthLocalDataSourceImpl extends AuthLocalDataSource {
  final StorageHelper storage;

  AuthLocalDataSourceImpl({required this.storage});

  @override
  Future<void> removeToken() async => await storage.remove(accessTokenKey);

  @override
  Future<void> saveToken(String token) async =>
      await storage.setString(accessTokenKey, token);
}
