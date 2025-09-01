import 'package:coachera/core/constants/strings.dart';
import 'package:coachera/core/utils/app_context.dart';
import 'package:coachera/features/course/presentation/widgets/progress_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';

import '../../../../core/constants/routes.dart';
import '../../../home/presentation/widgets/filter_sheet.dart';
import '../bloc/bloc/course_bloc.dart';

class UserCoursesScreen extends StatefulWidget {
  const UserCoursesScreen({super.key});

  @override
  State<UserCoursesScreen> createState() => _UserCoursesScreenState();
}

class _UserCoursesScreenState extends State<UserCoursesScreen> {
  @override
  void initState() {
    super.initState();
    context.read<CourseBloc>().add(GetUserCourses());
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CourseBloc, CourseState>(
      listener: (context, courseState) {
        if (courseState.status == CourseStatus.error) {
          context.showErrorSnackBar(massage: courseState.message);
        }
      },
      builder: (context, courseState) {
        return Scaffold(
          appBar: AppBar(
            title: const Text("My Courses"),
            actions: [
              IconButton(
                onPressed: () => showModalBottomSheet(
                  isScrollControlled: true,
                  useSafeArea: true,
                  builder: (context) => FilterSheet(
                    sortOptions: const ["name"],
                    onFilter: (filter) {
                      context.read<CourseBloc>().add(GetUserCourses());
                    },
                  ),
                  context: context,
                ),
                icon: const Icon(TablerIcons.adjustments_horizontal),
              )
            ],
          ),
          body: RefreshIndicator(
            onRefresh: () async {
              context.read<CourseBloc>().add(GetUserCourses());
            },
            child: BlocBuilder<CourseBloc, CourseState>(
              builder: (context, courseState) {
                if (courseState.status == CourseStatus.loading) {
                  // لو لسا عم يحمل → عرض loading cards
                  // return ListView.builder(
                  //   padding: const EdgeInsets.all(16),
                  //   itemCount: 3,
                  //   itemBuilder: (context, index) => const Padding(
                  //     padding: EdgeInsets.only(bottom: 16),
                  //     child: ProgressCard(
                  //       progressData: null, // مش مهم باللودينغ
                  //       onContinue: (){return ;},
                  //       state: ProgressCardState.loading,
                  //     ),
                  //   ),
                  // );
                  // }
                  //
                  // if (courseState.progress.isEmpty) {
                  //   return const Center(
                  //     child: Text("No courses found."),
                  //   );
                }

                return ListView.separated(
                  padding: const EdgeInsets.all(16),
                  itemBuilder: (context, index) {
                    final progress = courseState.progress[index];

                    final isCompleted = progress.materialCompletions.isEmpty
                        ? false
                        : progress.materialCompletions
                                .where((m) => m.completed)
                                .length ==
                            progress.materialCompletions.length;

                    return ProgressCard(
                      progressData: progress,
                      onContinue: () => context.push(
                        Routes.courseDetails,
                        arguments: {"course": progress.course},
                      ),
                      // state: /*ProgressCardState.loading ?*/ isCompleted
                      //     ? ProgressCardState.completed
                      //     : ProgressCardState.ongoing,
                    );
                  },
                  separatorBuilder: (context, index) =>
                      const SizedBox(height: 16),
                  itemCount: courseState.progress.length,
                );
              },
            ),
          ),
        );
      },
    );
  }
}

// import 'package:coachera/core/constants/strings.dart';
// import 'package:coachera/core/utils/app_context.dart';
// import 'package:coachera/features/course/presentation/widgets/progress_card.dart';
// import 'package:coachera/features/home/domain/param/sort_param.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';
// import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
//
// import '../../../../core/constants/routes.dart';
// import '../../../home/domain/param/list_param.dart';
// import '../../../home/presentation/widgets/filter_sheet.dart';
// import '../../domain/entities/course.dart';
// import '../bloc/bloc/course_bloc.dart';
// import '../widgets/course_horizontal_card.dart';
//
// class UserCoursesScreen extends StatefulWidget {
//   const UserCoursesScreen({super.key});
//
//   @override
//   State<UserCoursesScreen> createState() => _UserCoursesScreenState();
// }
//
// class _UserCoursesScreenState extends State<UserCoursesScreen> {
//   // final PagingController<int, Course> _pagingController =
//   //     PagingController(firstPageKey: 0);
//
//   @override
//   void initState() {
//     super.initState();
//     // _pagingController.addPageRequestListener((pageKey) {
//     context.read<CourseBloc>().add(GetUserCourses());
//     // });
//   }
//
//   @override
//   void dispose() {
//     // _pagingController.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return BlocConsumer<CourseBloc, CourseState>(
//       listener: (context, state) {
//         if (state.status == CourseStatus.success) {
//           // final startIndex = state.page * pageSize;
//           // final newItems =
//           //     state.progress.skip(startIndex).take(pageSize).toList();
//           //
//           // final isLastPage = newItems.length < pageSize;
//           //
//           // if (isLastPage) {
//           //   _pagingController.appendLastPage(newItems);
//           // } else {
//           //   final nextPageKey = state.page + 1;
//           //   _pagingController.appendPage(newItems, nextPageKey);
//           // }
//         } else if (state.status == CourseStatus.error) {
//           // _pagingController.error = state.message!.value;
//           context.showErrorSnackBar(massage: state.message);
//         }
//       },
//       builder: (context, state) {
//         return Scaffold(
//           appBar: AppBar(
//             title: const Text("My Courses"),
//             actions: [
//               IconButton(
//                 onPressed: () => showModalBottomSheet(
//                   isScrollControlled: true,
//                   useSafeArea: true,
//                   builder: (context) => FilterSheet(
//                       // todo : don't forget to add this
//                       sortOptions: ["name"],
//                       onFilter: (filter) =>
//                           context.read<CourseBloc>().add(GetUserCourses())),
//                   context: context,
//                 ),
//                 icon: Icon(TablerIcons.adjustments_horizontal),
//               )
//             ],
//           ),
//           body: RefreshIndicator(
//               onRefresh: () async {
//                 context.read<CourseBloc>().add(GetUserCourses());
//                 // _pagingController.refresh();
//               },
//               child: BlocBuilder<CourseBloc, CourseState>(
//                 builder: (context, state) => ListView.separated(
//                   padding: EdgeInsets.all(16),
//                   itemBuilder: (context, index) => ProgressCard(
//                     progressData: state.progress[index],
//                     onContinue: () => context.push(Routes.courseDetails,
//                         arguments: {"course": state.progress[index].course}),
//                     state: state.progress[index].courseCompletion
//                                 .materialCompletions
//                                 .where((m) => m.completed)
//                                 .length ==
//                             state.progress[index].courseCompletion
//                                 .materialCompletions.length
//                         ? ProgressCardState.completed
//                         : ProgressCardState.ongoing,
//                   ),
//                   separatorBuilder: (context, index) =>
//                       const SizedBox(height: 16),
//                   itemCount: state.progress.length,
//                 ),
//               )),
//         );
//       },
//     );
//   }
// }
