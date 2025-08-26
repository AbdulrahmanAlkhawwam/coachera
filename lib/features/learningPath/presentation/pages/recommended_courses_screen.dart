// import 'package:coachera/core/utils/app_context.dart';
// import 'package:coachera/features/course/domain/params/recommended_courses_param.dart';
// import 'package:coachera/features/course/presentation/bloc/bloc/course_bloc.dart';
// import 'package:coachera/features/home/presentation/widgets/filter_sheet.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';
// import 'package:shimmer/shimmer.dart';
//
// import '../../../../core/components/paginated_list.dart';
// import '../../data/model/course_model.dart';
// import '../../domain/entities/course.dart';
// import '../widgets/course_card.dart';
//
// class RecommendedCoursesScreen extends StatefulWidget {
//   const RecommendedCoursesScreen({super.key});
//
//   @override
//   State<RecommendedCoursesScreen> createState() =>
//       _RecommendedCoursesScreenState();
// }
//
// class _RecommendedCoursesScreenState extends State<RecommendedCoursesScreen> {
//   @override
//   Widget build(BuildContext context) {
//     return BlocConsumer<CourseBloc, CourseState>(
//       listener: (context, state) {
//         if (state.status == CourseStatus.error) {
//           context.showErrorSnackBar(massage: state.message);
//         }
//         // todo :: fix this
//         // if (state.status == CourseStatus.success) {
//         //   Navigator.canPop(context) ? context.pop() : null;
//         // }
//       },
//       builder: (context, state) => Scaffold(
//         appBar: AppBar(
//           title: const Text("Recommendation Courses"),
//           actions: [
//             IconButton(
//               onPressed: () => showModalBottomSheet(
//                 isScrollControlled: true,
//                 useSafeArea: true,
//                 builder: (context) => FilterSheet(
//                     sortOptions: [
//                       "Name",
//                       "Price",
//                       "stars",
//                     ],
//                     starsLength: 5,
//                     onFilter: (filter) =>
//                         context.read<CourseBloc>().add(GetRecommendedCourses(
//                               param: RecommendedCoursesParam(
//                                 filter: filter,
//                                 page: 0,
//                               ),
//                               reset: true,
//                             ))),
//                 context: context,
//               ),
//               icon: Icon(TablerIcons.adjustments_horizontal),
//             )
//           ],
//         ),
//         body: PaginatedScrollList<Course>(
//           listItem: state.courses,
//           fetchPage: (page) async => context
//               .read<CourseBloc>()
//               .add(GetRecommendedCourses(
//                 param:
//                     RecommendedCoursesParam(filter: FilterData(), page: page),
//                 reset: page == 0,
//               )),
//           pageSize: 10,
//           itemSeparator: const SizedBox(height: 0),
//           itemBuilder: (context, course, index) => CourseCard(course: course),
//           shimmerBuilder: () => _detailedShimmerCard(),
//         ),
//       ),
//     );
//   }
// }
//
// Widget _detailedShimmerCard() {
//   return Shimmer.fromColors(
//     baseColor: Colors.grey.shade800,
//     highlightColor: Colors.grey.shade600,
//     child: Container(
//       margin: const EdgeInsets.all(8),
//       decoration: BoxDecoration(
//         color: Colors.grey.shade900,
//         borderRadius: BorderRadius.circular(12),
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           // 🔹 Image placeholder
//           Container(
//             height: 160,
//             decoration: BoxDecoration(
//               color: Colors.grey.shade700,
//               borderRadius:
//                   const BorderRadius.vertical(top: Radius.circular(12)),
//             ),
//           ),
//
//           Padding(
//             padding: const EdgeInsets.all(12),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 // 🔹 Title placeholder
//                 Container(
//                   height: 18,
//                   width: 140,
//                   decoration: BoxDecoration(
//                     color: Colors.grey.shade700,
//                     borderRadius: BorderRadius.circular(6),
//                   ),
//                 ),
//                 const SizedBox(height: 8),
//
//                 // 🔹 Subtitle placeholder
//                 Container(
//                   height: 14,
//                   width: 220,
//                   decoration: BoxDecoration(
//                     color: Colors.grey.shade700,
//                     borderRadius: BorderRadius.circular(6),
//                   ),
//                 ),
//                 const SizedBox(height: 16),
//
//                 // 🔹 Price placeholder
//                 Container(
//                   height: 16,
//                   width: 90,
//                   decoration: BoxDecoration(
//                     color: Colors.grey.shade700,
//                     borderRadius: BorderRadius.circular(6),
//                   ),
//                 ),
//                 const SizedBox(height: 16),
//
//                 // 🔹 Rating + Favorite row
//                 Row(
//                   children: [
//                     // Stars placeholder
//                     Row(
//                       children: List.generate(
//                         5,
//                         (index) => Container(
//                           margin: const EdgeInsets.only(right: 4),
//                           height: 14,
//                           width: 14,
//                           decoration: BoxDecoration(
//                             color: Colors.grey.shade700,
//                             borderRadius: BorderRadius.circular(3),
//                           ),
//                         ),
//                       ),
//                     ),
//                     const SizedBox(width: 8),
//
//                     // Rating number placeholder
//                     Container(
//                       height: 14,
//                       width: 30,
//                       decoration: BoxDecoration(
//                         color: Colors.grey.shade700,
//                         borderRadius: BorderRadius.circular(6),
//                       ),
//                     ),
//
//                     const Spacer(),
//
//                     // Favorite icon placeholder
//                     Container(
//                       height: 24,
//                       width: 24,
//                       decoration: BoxDecoration(
//                         color: Colors.grey.shade700,
//                         shape: BoxShape.circle,
//                       ),
//                     ),
//                   ],
//                 )
//               ],
//             ),
//           ),
//         ],
//       ),
//     ),
//   );
// }
//
// // import 'dart:async';
// //
// // import 'package:flutter/material.dart';
// // import 'package:flutter_bloc/flutter_bloc.dart';
// // import 'package:shimmer/shimmer.dart';
// // import '../../../../core/components/paginated_list.dart';
// //
// // // import '../../../../core/components/paginated_scroll_list.dart'; // Your custom widget
// // import '../../data/model/course_model.dart';
// // import '../bloc/bloc/instructor_bloc.dart';
// //
// // class CoursesScreen extends StatefulWidget {
// //   const CoursesScreen({super.key});
// //
// //   @override
// //   State<CoursesScreen> createState() => _CoursesScreenState();
// // }
// //
// // class _CoursesScreenState extends State<CoursesScreen> {
// //   @override
// //   void initState() {
// //     super.initState();
// //     // Load initial data (page 0 or 1 depending on your API)
// //     // context.read<CourseBloc>().add(GetCoursesPaginated(page: 1));
// //   }
// //
// //   Future<List<CourseModel>> _fetchPage(int page) async {
// //     final completer = Completer<List<CourseModel>>();
// //
// //     // Dispatch the event to BLoC
// //     context.read<CourseBloc>().add(GetCoursesPaginated(
// //           page: page,
// //           completer: completer,
// //         ));
// //
// //     return completer.future;
// //   }
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(title: const Text('Courses')),
// //       body: BlocConsumer<CourseBloc, CourseState>(
// //         listener: (context, state) {
// //           // Handle any side effects or navigation here
// //         },
// //         builder: (context, state) {
// //           // If it's the initial load and we have no data yet
// //           if (state.status == CourseStatus.init ||
// //               (state.status == CourseStatus.loading && state.isFirstFetch!)) {
// //             return Center(child: CircularProgressIndicator());
// //           }
// //
// //           // For error state
// //           // if (state.status == CourseStatus.error) {
// //           //   return Center(
// //           //     child: Column(
// //           //       mainAxisAlignment: MainAxisAlignment.center,
// //           //       children: [
// //           //         Text(state.message!.value.toString()),
// //           //         ElevatedButton(
// //           //           onPressed: () => context
// //           //               .read<CourseBloc>()
// //           //               .add(GetCoursesPaginated(page: 1,completer: this.completer)),
// //           //           child: Text('Retry'),
// //           //         ),
// //           //       ],
// //           //     ),
// //           //   );
// //           // }
// //
// //           // Get the current list of courses from the state
// //           // final currentState = state.status == CourseStatus.success;
// //           // final courses = state.courses;
// //
// //           return PaginatedScrollList<CourseModel>(
// //             fetchPage: _fetchPage,
// //             pageSize: 15,
// //             // Should match your API's page size
// //             errorMessage: 'Something went wrong, tap to retry',
// //             itemBuilder: (context, course, index) {
// //               return ListTile(
// //                 title: Text(course.title),
// //                 subtitle: Text(course.description),
// //               );
// //             },
// //             itemSeparator: const Divider(height: 1),
// //             shimmerBuilder: () => Padding(
// //               padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
// //               child: Shimmer.fromColors(
// //                 baseColor: Colors.grey[300]!,
// //                 highlightColor: Colors.grey[100]!,
// //                 child: const SizedBox(height: 60, width: double.infinity),
// //               ),
// //             ),
// //           );
// //         },
// //       ),
// //     );
// //   }
// // }
//
// // import 'dart:async';
// //
// // import 'package:flutter/material.dart';
// // import 'package:flutter_bloc/flutter_bloc.dart';
// // import 'package:shimmer/shimmer.dart';
// // import '../../../../core/components/paginated_list.dart';
// // import '../../data/model/course_model.dart';
// // import '../bloc/bloc/instructor_bloc.dart';
// //
// // // import '../manager/manager/review_event.dart';
// // // import '../manager/manager/review_state.dart';
// // // import '../../domain/entities/review_model.dart';
// // // import '../../../../core/components/paginated_scroll_list.dart'; // your widget
// // import '../../../../core/utils/app_context.dart';
// //
// // class CoursesScreen extends StatefulWidget {
// //   const CoursesScreen({super.key});
// //
// //   @override
// //   State<CoursesScreen> createState() => _CoursesScreenState();
// // }
// //
// // class _CoursesScreenState extends State<CoursesScreen> {
// //   @override
// //   void initState() {
// //     super.initState();
// //     // Just preload the first state to fill the manager (optional)
// //     // context
// //     //     .read<CourseBloc>()
// //     //     .add(GetCoursesPaginated(page: 0, completer: Completer()));
// //   }
// //
// //   Future<List<CourseModel>> _fetchPage(int page) async {
// //     final bloc = context.read<CourseBloc>();
// //     final completer = Completer<List<CourseModel>>();
// //
// //     bloc.add(GetCoursesPaginated(page: page, completer: completer));
// //
// //     return completer.future;
// //   }
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(title: const Text('Courses')),
// //       body: PaginatedScrollList<CourseModel>(
// //         fetchPage: _fetchPage,
// //         pageSize: 5,
// //         errorMessage: 'Something went wrong, tap to retry',
// //         itemBuilder: (context, course, index) {
// //           return ListTile(
// //             title: Text(course.title),
// //             subtitle: Text(course.description),
// //           );
// //         },
// //         itemSeparator: const Divider(height: 1),
// //         shimmerBuilder: () => Padding(
// //           padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
// //           child: Shimmer.fromColors(
// //             baseColor: Colors.grey[300]!,
// //             highlightColor: Colors.grey[100]!,
// //             child: const SizedBox(height: 60, width: double.infinity),
// //           ),
// //         ),
// //       ),
// //     );
// //   }
// // }
//
// // import 'package:flutter/material.dart';
// // import 'package:flutter_bloc/flutter_bloc.dart';
// // import '../manager/manager/review_bloc.dart';
// //
// // class CoursesScreen extends StatefulWidget {
// //   const CoursesScreen({super.key});
// //
// //   @override
// //   State<CoursesScreen> createState() => _CoursesScreenState();
// // }
// //
// // class _CoursesScreenState extends State<CoursesScreen> {
// //   @override
// //   void initState() {
// //     super.initState();
// //     context.read<CourseBloc>().add(GetCourses());
// //   }
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(title: const Text('Courses')),
// //       body: BlocBuilder<CourseBloc, CourseState>(
// //         builder: (context, state) {
// //           if (state.status == CourseStatus.loading) {
// //             return const Center(child: CircularProgressIndicator());
// //           } else if (state.status == CourseStatus.success) {
// //             final courses = state.courses;
// //
// //             if (courses?.isEmpty ?? true) {
// //               return const Center(child: Text('No courses available'));
// //             }
// //             return ListView.builder(
// //               itemCount: courses?.length,
// //               itemBuilder: (_, index) {
// //                 final course = courses![index];
// //                 return ListTile(
// //                   title: Text(course.title),
// //                   subtitle: Text(course.description),
// //                 );
// //               },
// //             );
// //           } else if (state.status == CourseStatus.error) {
// //             return Center(child: Text('Error: ${state.message}'));
// //           }
// //
// //           return const SizedBox.shrink(); // Initial or unknown state
// //         },
// //       ),
// //     );
// //   }
// // }
//
// // import 'package:flutter/material.dart';
// // import 'package:flutter_bloc/flutter_bloc.dart';
// // import '../manager/manager/review_bloc.dart'; // adjust import to your path
// // // import '../manager/manager/review_state.dart';
// // // import '../manager/manager/review_event.dart';
// // // import '../../domain/entities/review_model.dart'; // your model
// //
// // class CoursesScreen extends StatelessWidget {
// //   const CoursesScreen({super.key});
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(title: const Text('Courses')),
// //       body: BlocBuilder<CourseBloc, CourseState>(
// //         builder: (context, state) {
// //           if (state.status == CourseStatus.loading) {
// //             return const Center(child: CircularProgressIndicator());
// //           } else if (state.status == CourseStatus.success) {
// //             final courses = state.courses;
// //
// //             if (state.courses?.isEmpty ?? true) {
// //               return const Center(child: Text('No courses available'));
// //             }
// //
// //             return ListView.builder(
// //               itemCount: courses?.length ?? 0,
// //               itemBuilder: (_, index) {
// //                 final course = courses![index];
// //                 return ListTile(
// //                   title: Text(course.title),
// //                   subtitle: Text(course.description),
// //                 );
// //               },
// //             );
// //           } else if (state.status == CourseStatus.error) {
// //             return Center(child: Text('Error: ${state.message}'));
// //           }
// //
// //           return const SizedBox.shrink(); // default (initial) state
// //         },
// //       ),
// //     );
// //   }
// // }
// //
//
// // import 'package:flutter/material.dart';
// // import 'package:shimmer/shimmer.dart';
// //
// // import '../../../../core/components/paginated_list.dart';
// // import '../../domain/entities/course.dart';
// //
// // final _allDummyCourses = [];
// // // List.generate(
// // //   50,
// // //   (index) => Course(
// // //       id: index,
// // //       title: "course$index",
// // //       description: "Comprehensive course on org"),
// // // );
// //
// // Future<List<Course>> getDummyCoursesPage(int page, {int pageSize = 10}) async {
// //   await Future.delayed(const Duration(seconds: 1)); // simulate network delay
// //
// //   final start = page * pageSize;
// //   final end = start + pageSize;
// //
// //   if (start >= _allDummyCourses.length) {
// //     return [];
// //   }
// //
// //   // return _allDummyCourses.sublist(
// //   //   start,
// //   //   end > _allDummyCourses.length ? _allDummyCourses.length : end,
// //   // );
// //   return [];
// // }
// //
// // class CoursesScreen extends StatelessWidget {
// //   const CoursesScreen({super.key});
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(title: Text('Courses')),
// //       body: PaginatedScrollList<Course>(
// //         fetchPage: getDummyCoursesPage,
// //         itemBuilder: (context, course, index) => ListTile(
// //           title: Text(course.title),
// //           subtitle: Text(course.description),
// //         ),
// //         shimmerBuilder: () => Padding(
// //           padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
// //           child: Shimmer.fromColors(
// //             baseColor: Colors.grey[300]!,
// //             highlightColor: Colors.grey[100]!,
// //             child: const SizedBox(height: 60, width: double.infinity),
// //           ),
// //         ),
// //         itemSeparator: const SizedBox(height: 8),
// //       ),
// //     );
// //   }
// // }
