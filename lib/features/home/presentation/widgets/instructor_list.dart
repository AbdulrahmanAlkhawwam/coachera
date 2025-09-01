import 'package:flutter/material.dart';

import '../../../../core/utils/app_context.dart';
import '../../../../core/constants/routes.dart';
import '../../../instructor/domain/entities/instructor.dart';
import '../../../instructor/presentation/widgets/instructor_card.dart';

class InstructorList extends StatelessWidget {
  const InstructorList({
    super.key,
    required this.instructors,
    required this.loading,
    this.showMore,
  });

  final bool? showMore;

  final bool loading;

  final List<Instructor> instructors;

  @override
  Widget build(BuildContext context) {
    return Column(mainAxisSize: MainAxisSize.min, children: [
      Row(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(vertical: showMore ?? true ? 0 : 16),
            child: Text("Instructors"),
          ),
          const Spacer(),
          if (showMore ?? true)
            TextButton(
              onPressed: () => context.push(Routes.instructors),
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
          itemCount: loading ? 8 : instructors.length,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) => InstructorCard(
            loading: loading,
            instructor: loading ? null : instructors[index],
          ),
          shrinkWrap: true,
        ),
      ),
    ]);
  }
}
