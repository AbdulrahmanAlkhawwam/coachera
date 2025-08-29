import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

import '../../../../core/constants/routes.dart';
import '../../../../core/helpers/http/http_service.dart';
import '../../domain/params/change_password_param.dart';
import '../../domain/params/forget_password_param.dart';
import '../../domain/params/login_param.dart';
import '../../domain/params/register_param.dart';
import '../model/user_model.dart';

abstract class AuthRemoteDataSource {
  Future<String> login(LoginParam param);

  Future<void> logout();

  Future<bool> otp(LoginParam param);

  Future<String> register(RegisterParam param);

  Future<void> forgetPassword(ForgetPasswordParam param);

  Future<void> changePassword(ChangePasswordParam param);

  Future<UserModel> getMe();

  Future<void> registerDeviceToken(String userToken);
}

class AuthRemoteDataSourceImpl extends AuthRemoteDataSource {
  final HttpService http;

  AuthRemoteDataSourceImpl({required this.http});

  @override
  Future<String> login(LoginParam param) {
    return http.handleApiCall(() async {
      final response = await http.post(
        Endpoint.login,
        body: {
          'identifier': param.email,
          'password': param.password,
        },
      );
      return response.data['accessToken'];
    });
  }

  @override
  Future<void> logout() {
    return http.handleApiCall(() async {
      await http.post(Endpoint.logout);
    });
  }

  @override
  Future<bool> otp(LoginParam param) {
    return http.handleApiCall(() async {
      final response = await http.post(
        Endpoint.validateOTP,
        queryParameters: {
          'email': param.email,
          'otp': param.password,
        },
      );
      return response.statusCode == 200;
    });
  }

  @override
  Future<String> register(RegisterParam param) {
    return http.handleApiCall(() async {
      final response = await http.post(
        Endpoint.registerUser,
        body: {
          'username': param.name,
          'email': param.email,
          'password': param.password,
          'role': 'student',
          'details': {
            "birthDate": DateFormat("yyyy-MM-dd").format(param.birthDate),
            "education": param.education,
            "firstName": param.firstName,
            "gender": param.gender,
            "lastName": param.lastName,
            "phoneNumber": "+${param.phoneNumber}",
            "address": param.address
          }
        },
      );
      print(response.data);
      return response.data['accessToken'];
    });
  }

  @override
  Future<void> forgetPassword(ForgetPasswordParam param) {
    return http.handleApiCall(() async {
      await http.post(
        Endpoint.forgetPassword,
        queryParameters: {
          'email': param.email,
        },
      );
    });
  }

  @override
  Future<void> changePassword(ChangePasswordParam param) {
    return http.handleApiCall(() async {
      await http.post(
        Endpoint.changePassword,
        queryParameters: {
          'email': param.email,
          'otp': param.passkey,
          'newPassword': param.newPassword,
        },
      );
    });
  }

  @override
  Future<UserModel> getMe() async {
    final response = await http.get(Endpoint.me);
    return UserModel.fromJson(response.data);
  }

  Future<void> registerDeviceToken(String userToken) async {
    String? fcmToken = await FirebaseMessaging.instance.getToken();
    if (fcmToken == null) return;

    final response = await http.handleApiCall(
      () => http.post(
        Endpoint.deviceToken,
        body: {
          "deviceToken": fcmToken,
          "platform": "android",
        },
      ),
    );

    if (response.statusCode == 200) {
      print('Device token registered successfully');
    } else {
      print('Failed to register device token: ${response.data.toString()}');
    }
  }
}
