import 'package:flutter/material.dart';

import '../../../../core/utils/app_context.dart';
import '../../../../core/constants/routes.dart';
import '../../../course/domain/entities/course.dart';
import '../../../course/presentation/widgets/course_vertical_card.dart';

class CoursesList extends StatelessWidget {
  const CoursesList({
    super.key,
    required this.courses,
    required this.loading,
  });

  final bool loading;

  final List<Course> courses;

  @override
  Widget build(BuildContext context) {
    return Column(mainAxisSize: MainAxisSize.min, children: [
      Row(
        children: [
          Text("Recommended Courses"),
          const Spacer(),
          TextButton(
            onPressed: () => context.push(Routes.recommendedCourses),
            child: Text("See All"),
          ),
        ],
      ),
      SizedBox(
        width: double.infinity,
        height: 300,
        child: ListView.separated(
          separatorBuilder: (context, index) => const SizedBox(
            width: 16,
          ),
          itemCount: loading ? 8 : courses.length,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) => CourseVerticalCard(
            loading: loading,
            course: loading ? null : courses[index],
          ),
          shrinkWrap: true,
        ),
      ),
    ]);
  }
}
