import '../../../../core/constants/strings.dart';
import '../../../../core/helpers/storage_helper.dart';

abstract class AuthLocalDataSource {
  Future<void> localLogout();
  Future<void> saveToken(String token);
  Future<void> guestLogin();
  String? getToken();
}

class AuthLocalDataSourceImpl extends AuthLocalDataSource {
  final StorageHelper storage;

  AuthLocalDataSourceImpl({required this.storage});

  @override
  Future<void> localLogout() async {
    await storage.remove(accessTokenKey);
    await storage.remove(guestKey);
  }

  @override
  Future<void> saveToken(String token) async {
    await storage.setString(accessTokenKey, token);
  }

  @override
  Future<void> guestLogin() async {
    await storage.setBool(guestKey, true);
  }

  @override
  String? getToken() {
    return storage.getString(accessTokenKey);
  }
}
