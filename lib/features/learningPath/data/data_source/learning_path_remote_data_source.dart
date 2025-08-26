

// import '../../../home/data/models/user_model.dart';

import '../../../../core/helpers/http/http_service.dart';

abstract class LearningPathRemoteDataSource {

  // Future<List<CourseModel>> getLearningPaths({int? page});

}
class LearningPathRemoteDataSourceImpl extends LearningPathRemoteDataSource {
  final HttpService http;

  LearningPathRemoteDataSourceImpl({required this.http});

  // @override
  // Future<List<CourseModel>> getCourses({int? page}) async {
  //   final response = await http.handleApiCall(() async => await http.get(
  //         Endpoint.courses,
  //         queryParameters: {
  //           "page": page.toString(),
  //         },
  //       ));
  //
  //   final List<dynamic> courses = response.data['content'];
  //
  //   return courses.map((e) => CourseModel.fromJson(e)).toList();
  // }

  // @override
  // Future<List<CourseModel>> getRecommendedCourses(
  //     {int? page, required FilterData filter}) async {
  //   final response = await http.handleApiCall(() async => await http.get(
  //         Endpoint.recommendedCourses,
  //         queryParameters: {
  //           "page": page.toString(),
  //           "size": 15.toString(),
  //           if (filter.sortBy != null) "sortBy": filter.sortBy!,
  //           if (filter.sortType != null) "sortDirection": filter.sortType!,
  //         },
  //       ));
  //
  //   final List<dynamic> courses = response.data["content"];
  //
  //   return courses.map((e) => CourseModel.fromJson(e)).toList();
  // }

  // @override
  // Future<List<CourseModel>> getLearningPaths({int? page}) {
  //   TODO: implement getLearningPaths
    // throw UnimplementedError();
  // }

// @override
// Future<String> login(LoginParam param) async {
//   return await http.handleApiCall(
//     () async {
//       final response = await http.post(
//         Endpoint.login,
//         body: {
//           "identifier": param.email,
//           "password": param.password,
//         },
//       );
//       return response.data['accessToken'];
//     },
//   );
// }

// @override
// Future<void> logout() async =>
//     await http.handleApiCall(() async => await http.post(Endpoint.logout));

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
// @override
// Future<void> register(RegisterParam param) async {
//   return await http.handleApiCall(() async {
//     final response = await http.post(
//       "/auth/register",
//       body: {
//         "username": param.name,
//         "email": param.email,
//         "password": param.password,
//         "role": "student",
//
// "first_name": param.firstName,
// "last_name": param.lastName,
// "phone": param.phone.substring(1),
// "password": param.password,
// },
// ) as Map<String, dynamic>;
// return UserModel.fromJson(response);
// return null;
// });
// }
}
