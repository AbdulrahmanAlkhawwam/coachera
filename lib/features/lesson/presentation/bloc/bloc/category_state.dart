// part of 'organization_bloc.dart';
//
// enum CourseStatus {
//   init,
//   loading,
//   error,
//   success,
// }
//
// @immutable
// class CategoryState {
//   final CourseStatus status;
//   final Message? message;
//   final List<Category>? courses;
//
//   const CategoryState({
//     this.status = CourseStatus.init,
//     this.message,
//     this.courses = const [],
//   });
//
//   CategoryState copyWith({
//     CourseStatus? status,
//     Message? message,
//     List<Category>? courses,
//   }) =>
//       CategoryState(
//         status: status ?? this.status,
//         message: message ?? this.message,
//         courses: courses ?? this.courses,
//       );
// }
