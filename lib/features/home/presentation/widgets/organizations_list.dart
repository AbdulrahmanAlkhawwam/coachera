import 'package:coachera/features/organization/presentation/widgets/organization_card.dart';
import 'package:flutter/material.dart';

import '../../../../core/utils/app_context.dart';
import '../../../../core/constants/routes.dart';
import '../../../course/domain/entities/course.dart';
import '../../../course/presentation/widgets/course_vertical_card.dart';
import '../../../organization/domain/entities/organization.dart';

class OrganizationsList extends StatelessWidget {
  const OrganizationsList({
    super.key,
    required this.organizations,
    required this.loading,
  });

  final bool loading;

  final List<Organization> organizations;

  @override
  Widget build(BuildContext context) {
    return Column(mainAxisSize: MainAxisSize.min, children: [
      Row(
        children: [
          Text("Organizations"),
          const Spacer(),
          TextButton(
            onPressed: () => context.push(Routes.organizations),
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
          itemCount: loading ? 8 : organizations.length,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) => OrganizationCard(
            loading: loading,
            organization: loading ? null : organizations[index],
          ),
          shrinkWrap: true,
        ),
      ),
    ]);
  }
}
