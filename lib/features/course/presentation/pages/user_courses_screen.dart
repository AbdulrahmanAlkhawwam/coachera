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
                return ListView.separated(
                  padding: const EdgeInsets.all(16),
                  itemBuilder: (context, index) {
                    final progress = courseState.progress[index];

                    return ProgressCard(
                      progressData: progress,
                      onContinue: () => context.push(
                        Routes.courseDetails,
                        arguments: {
                          "course": progress.course,
                          'enrollment': progress.materialCompletions,
                        },
                      ),
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
