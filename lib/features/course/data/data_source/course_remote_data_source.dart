import 'package:coachera/core/constants/routes.dart';
import 'package:coachera/core/constants/strings.dart';
import 'package:coachera/features/course/data/model/progress_model.dart';

import '../../../../core/helpers/http/http_service.dart';
import '../../../home/domain/param/list_param.dart';
import '../model/course_model.dart';
import '../model/enrollment_model.dart';

// import '../../../home/data/models/user_model.dart';

abstract class CourseRemoteDataSource {
  // Future <CourseModel> getCourse ({int id});

  // Future<List<CourseModel>> getCourses({int? page});

  Future<List<CourseModel>> getRecommendedCourses(ListParam param);

  Future<EnrollmentModel> enroll(int courseId);

  Future<List<CourseModel>> getInstructorCourses(int instructorId);

  Future<List<CourseModel>> getLearningPathCourses(int learningPathId);

  Future<List<ProgressModel>> getProgress();
// Future<String> login(LoginParam param);

// Future<void> logout();

// Future<bool> otp(String passkey);

// Future<UserModel> register(RegisterParam param);
//   Future<void> register(RegisterParam param);
}

class CourseRemoteDataSourceImpl extends CourseRemoteDataSource {
  final HttpService http;

  CourseRemoteDataSourceImpl({required this.http});

  // @override
  // Future<List<CourseModel>> getCourses({int? page}) async {
    // final response = await http.handleApiCall(() async => await http.get(
          // Endpoint.courses,
          // queryParameters: {
            // "page": page.toString(),
          // },
        // ));

    // final List<dynamic> courses = response.data['content'];

    // return courses.map((e) => CourseModel.fromJson(e)).toList();
  // }

  @override
  Future<List<CourseModel>> getRecommendedCourses(ListParam param) async {
    final response = await http.handleApiCall(() async => await http.get(
          Endpoint.recommendedCourses,
          queryParameters: {
            "page": param.page.toString(),
            "size": pageSize.toString(),
            if (param.sort.sortBy != null) "sortBy": param.sort.sortBy!,
            if (param.sort.sortDirection != null)
              "sortDirection": param.sort.sortDirection!,
          },
        ));

    final List<dynamic> courses = response.data["content"];

    return courses.map((e) => CourseModel.fromJson(e)).toList();
  }

  @override
  Future<EnrollmentModel> enroll(int courseId) async {
    final response = await http.handleApiCall(() async => await http.post(
          Endpoint.enroll(courseId),
        ));
    return EnrollmentModel.fromJson(response.data);
  }

  @override
  Future<List<CourseModel>> getInstructorCourses(int instructorId) async {
    final response = await http.handleApiCall(
        () async => await http.get(Endpoint.instructorCourses(instructorId)));

    final List<dynamic> courses = response.data;

    return courses.map((e) => CourseModel.fromJson(e)).toList();
  }

  @override
  Future<List<ProgressModel>> getProgress() async {
    final response =
        await http.handleApiCall(() async => await http.get(Endpoint.progress));

    final List<dynamic> courses = response.data;

    return courses.map((e) => ProgressModel.fromJson(e)).toList();
  }

  @override
  Future<List<CourseModel>> getLearningPathCourses(int learningPathId) async {
    final response = await http.handleApiCall(() async =>
        await http.get(Endpoint.learningPathCourses(learningPathId)));

    final List<dynamic> courses = response.data["content"];

    return courses.map((e) => CourseModel.fromJson(e)).toList();
  }

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
