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

  Future<void> register(RegisterParam param);

  Future<void> forgetPassword(ForgetPasswordParam param);

  Future<void> changePassword(ChangePasswordParam param);

  Future<UserModel> getMe();
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
  Future<void> register(RegisterParam param) {
    // TODO: Fix return value, possibly return UserModel later
    return http.handleApiCall(() async {
      await http.post(
        '/auth/register',
        body: {
          'username': param.name,
          'email': param.email,
          'password': param.password,
          'role': 'student',
        },
      );
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
}
