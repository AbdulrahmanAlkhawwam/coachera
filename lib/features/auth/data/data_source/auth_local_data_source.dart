import 'package:firebase_messaging/firebase_messaging.dart';

import '../../../../core/constants/strings.dart';
import '../../../../core/helpers/storage_helper.dart';

abstract class AuthLocalDataSource {
  Future<void> guestLogin();

  Future<void> localLogout();

  Future<void> setGuest(bool guest);

  Future<void> removeGuest();

  bool? getGuest();

  Future<void> setToken(String token);

  Future<void> removeToken();

  String? getToken();
}

class AuthLocalDataSourceImpl extends AuthLocalDataSource {
  final StorageHelper storage;

  AuthLocalDataSourceImpl({required this.storage});

  @override
  Future<void> localLogout() async {
    removeToken();
    removeGuest();
    removeDeviceToken();
  }

  @override
  Future<void> guestLogin() async {
    setGuest(true);
  }

  @override
  String? getToken() {
    return storage.getString(accessTokenKey);
  }

  @override
  bool? getGuest() {
    return storage.getBool(guestKey);
  }

  @override
  Future<void> setToken(String token) async {
    await storage.setString(accessTokenKey, token);
  }

  @override
  Future<void> setGuest(bool guest) async {
    await storage.setBool(guestKey, guest);
  }

  @override
  removeToken() async {
    await storage.remove(accessTokenKey);
  }

  removeDeviceToken() async {
    await FirebaseMessaging.instance.deleteToken();
  }

  @override
  removeGuest() async {
    await storage.remove(guestKey);
  }
}
