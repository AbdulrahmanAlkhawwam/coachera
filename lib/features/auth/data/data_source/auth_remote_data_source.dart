import '../../../../core/constants/routes.dart';
import '../../../../core/helpers/http/http_service.dart';
import '../../domain/params/login_param.dart';
import '../../domain/params/register_param.dart';

abstract class AuthRemoteDataSource {
  Future<String> login(LoginParam param);

  Future<void> logout();

// Future<bool> otp(String passkey);

  Future<void> register(RegisterParam param);
}

class AuthRemoteDataSourceImpl extends AuthRemoteDataSource {
  final HttpService http;

  AuthRemoteDataSourceImpl({required this.http});

  @override
  Future<String> login(LoginParam param) async {
    return await http.handleApiCall(
      () async {
        final response = await http.post(
          Endpoint.login,
          body: {
            "identifier": param.email,
            "password": param.password,
          },
        );
        return response.data['accessToken'];
      },
    );
  }

  @override
  Future<void> logout() async =>
      await http.handleApiCall(() async => await http.post(Endpoint.logout));

// @override
// Future<bool> otp(String passkey) async {
//   return await http.handleApiCall(() async {
//     final response = await http.post(
//       "/register/otp",
//       body: {"otp": passkey},
//     ) as Map<String, dynamic>;
//     return response["status"];
//   });
// }

/*
@override
Future<UserModel> register(RegisterParam param) async {
  return await http.handleApiCall(() async {
    final response = await http.post(
      "/register",
      body: {
        "first_name": param.firstName,
        "last_name": param.lastName,
        "phone": param.phone.substring(1),
        "password": param.password,
      },
    ) as Map<String, dynamic>;
    return UserModel.fromJson(response);
  });
}
*/
  @override
  Future<void> register(RegisterParam param) async {
    // todo : fix this function for student
    // todo : fix the return value
    return await http.handleApiCall(() async {
      final response = await http.post(
        "/auth/register",
        body: {
          "username": param.name,
          "email": param.email,
          "password": param.password,
          "role": "student",

          // "first_name": param.firstName,
          // "last_name": param.lastName,
          // "phone": param.phone.substring(1),
          // "password": param.password,
        },
      ) as Map<String, dynamic>;
      // return UserModel.fromJson(response);
      return null;
    });
  }
}
