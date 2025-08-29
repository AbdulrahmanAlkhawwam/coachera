import '../../../../core/constants/routes.dart';
import '../../../../core/helpers/http/http_service.dart';
import '../../domain/param/quiz_param.dart';
import '../model/material_model.dart';

abstract class MaterialRemoteDataSource {
  // Future <CourseModel> getCourse ({int id});

  Future<MaterialModel> getMaterial({int? id});

  Future<void> submitQuiz(QuizParam param);
// Future<List<CourseModel>> getCourses({int? page});
// Future<String> login(LoginParam param);

// Future<void> logout();

// Future<bool> otp(String passkey);

// Future<UserModel> register(RegisterParam param);
//   Future<void> register(RegisterParam param);
}

class MaterialRemoteDataSourceImpl extends MaterialRemoteDataSource {
  final HttpService http;

  MaterialRemoteDataSourceImpl({required this.http});

  // @override
  // Future<List<CategoryModel>> getCategories({int? page}) async {
  //   final response = await http.handleApiCall(
  //     () async => await http.get(
  //       Endpoint.categories,
  //       queryParameters: {
  //         "page": page.toString(),
  //         "size": 10.toString(),
  //         "sortBy": "id",
  //         "sortDirection": "desc"
  //       },
  //     ),
  //   );
  //   final List<dynamic> content = response.data['content'];
  //   return content.map((e) => CategoryModel.fromJson(e)).toList();
  // }

  @override
  Future<MaterialModel> getMaterial({int? id}) async {
    final response = await http.handleApiCall(
      () async => await http.get(Endpoint.getMaterials(id)),
    );
    return MaterialModel.fromJson(response.data);
  }

  @override
  Future<void> submitQuiz(QuizParam param) async {
    final response = await http.handleApiCall(() async => await http.post(
          Endpoint.submitQuiz,
          body: {
            "quizId": param.quizId,
            "questions": param.questions,
          },
        ));
    print(response.data);
  }

// @override
// Future<List<CourseModel>> getCourses({int? page}) async {
//   final response = await http.handleApiCall(() async => await http.get(
//         Endpoint.courses,
//         queryParameters: {
//           "page": page.toString(),
//         },
//       ));
//
//   final List<dynamic> content = response.data['content'];
//
//   return content.map((e) => CourseModel.toMap(e)).toList();
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
