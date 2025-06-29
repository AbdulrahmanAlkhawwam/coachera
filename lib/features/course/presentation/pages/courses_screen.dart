import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';
import '../../../../core/components/paginated_list.dart';
import '../../data/model/course_model.dart';
import '../bloc/bloc/course_bloc.dart';

// import '../bloc/bloc/course_event.dart';
// import '../bloc/bloc/course_state.dart';
// import '../../domain/entities/course_model.dart';
// import '../../../../core/components/paginated_scroll_list.dart'; // your widget
import '../../../../core/utils/app_context.dart';

class CoursesScreen extends StatefulWidget {
  const CoursesScreen({super.key});

  @override
  State<CoursesScreen> createState() => _CoursesScreenState();
}

class _CoursesScreenState extends State<CoursesScreen> {
  @override
  void initState() {
    super.initState();
    // Just preload the first state to fill the bloc (optional)
    context
        .read<CourseBloc>()
        .add(GetCoursesPaginated(page: 0, completer: Completer()));
  }

  Future<List<CourseModel>> _fetchPage(int page) async {
    final bloc = context.read<CourseBloc>();
    final completer = Completer<List<CourseModel>>();

    bloc.add(GetCoursesPaginated(page: page, completer: completer));

    return completer.future;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Courses')),
      body: PaginatedScrollList<CourseModel>(
        fetchPage: _fetchPage,
        pageSize: 15,
        errorMessage: 'Something went wrong, tap to retry',
        itemBuilder: (context, course, index) {
          return ListTile(
            title: Text(course.title),
            subtitle: Text(course.description),
          );
        },
        itemSeparator: const Divider(height: 1),
        shimmerBuilder: () => Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[100]!,
            child: const SizedBox(height: 60, width: double.infinity),
          ),
        ),
      ),
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import '../bloc/bloc/course_bloc.dart';
//
// class CoursesScreen extends StatefulWidget {
//   const CoursesScreen({super.key});
//
//   @override
//   State<CoursesScreen> createState() => _CoursesScreenState();
// }
//
// class _CoursesScreenState extends State<CoursesScreen> {
//   @override
//   void initState() {
//     super.initState();
//     context.read<CourseBloc>().add(GetCourses());
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text('Courses')),
//       body: BlocBuilder<CourseBloc, CourseState>(
//         builder: (context, state) {
//           if (state.status == CourseStatus.loading) {
//             return const Center(child: CircularProgressIndicator());
//           } else if (state.status == CourseStatus.success) {
//             final courses = state.courses;
//
//             if (courses?.isEmpty ?? true) {
//               return const Center(child: Text('No courses available'));
//             }
//             return ListView.builder(
//               itemCount: courses?.length,
//               itemBuilder: (_, index) {
//                 final course = courses![index];
//                 return ListTile(
//                   title: Text(course.title),
//                   subtitle: Text(course.description),
//                 );
//               },
//             );
//           } else if (state.status == CourseStatus.error) {
//             return Center(child: Text('Error: ${state.message}'));
//           }
//
//           return const SizedBox.shrink(); // Initial or unknown state
//         },
//       ),
//     );
//   }
// }

// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import '../bloc/bloc/course_bloc.dart'; // adjust import to your path
// // import '../bloc/bloc/course_state.dart';
// // import '../bloc/bloc/course_event.dart';
// // import '../../domain/entities/course_model.dart'; // your model
//
// class CoursesScreen extends StatelessWidget {
//   const CoursesScreen({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text('Courses')),
//       body: BlocBuilder<CourseBloc, CourseState>(
//         builder: (context, state) {
//           if (state.status == CourseStatus.loading) {
//             return const Center(child: CircularProgressIndicator());
//           } else if (state.status == CourseStatus.success) {
//             final courses = state.courses;
//
//             if (state.courses?.isEmpty ?? true) {
//               return const Center(child: Text('No courses available'));
//             }
//
//             return ListView.builder(
//               itemCount: courses?.length ?? 0,
//               itemBuilder: (_, index) {
//                 final course = courses![index];
//                 return ListTile(
//                   title: Text(course.title),
//                   subtitle: Text(course.description),
//                 );
//               },
//             );
//           } else if (state.status == CourseStatus.error) {
//             return Center(child: Text('Error: ${state.message}'));
//           }
//
//           return const SizedBox.shrink(); // default (initial) state
//         },
//       ),
//     );
//   }
// }
//
// // import 'package:coachera/features/course/presentation/widgets/category_card.dart';
// // import 'package:flutter/material.dart';
// //
// // import '../../../../core/components/paginated_list.dart';
// // import '../../domain/entities/category.dart';
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
// //   return _allDummyCourses.sublist(
// //     start,
// //     end > _allDummyCourses.length ? _allDummyCourses.length : end,
// //   );
// // return [];
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
// //         itemBuilder: (context, course, index) => CourseCard(course: course),
// //         shimmerBuilder: () => CourseCard(
// //           isLoading: true,
// //         ),
// //         itemSeparator: const SizedBox(height: 8),
// //       ),
// //     );
// //   }
// // }
