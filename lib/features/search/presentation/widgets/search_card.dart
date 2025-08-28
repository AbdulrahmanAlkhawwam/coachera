import 'package:coachera/core/components/custom_input.dart';
import 'package:coachera/core/constants/routes.dart';
import 'package:coachera/core/utils/app_context.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';

import '../../../category/domain/entities/category.dart';

class SearchCard extends StatelessWidget {
  const SearchCard({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomInput(
      onTap: () => context.push(
        Routes.search,
        arguments: {
          "category": [
            Category(id: 1, iconName: "code", title: "Coding"),
            Category(id: 2, iconName: "design", title: "Design"),
            Category(id: 3, iconName: "marketing", title: "Marketing"),
            Category(id: 1, iconName: "code", title: "Coding"),
            Category(id: 2, iconName: "design", title: "Design"),
            Category(id: 3, iconName: "marketing", title: "Marketing"),
            Category(id: 1, iconName: "code", title: "Coding"),
            Category(id: 2, iconName: "design", title: "Design"),
            Category(id: 3, iconName: "marketing", title: "Marketing"),
            Category(id: 1, iconName: "code", title: "Coding"),
            Category(id: 2, iconName: "design", title: "Design"),
            Category(id: 3, iconName: "marketing", title: "Marketing"),
          ],
          "popularSearches": [
            Category(id: 1, iconName: "code", title: "Coding"),
            Category(id: 2, iconName: "design", title: "Design"),
            Category(id: 3, iconName: "marketing", title: "Marketing"),
            Category(id: 1, iconName: "code", title: "Coding"),
            Category(id: 2, iconName: "design", title: "Design"),
            Category(id: 3, iconName: "marketing", title: "Marketing"),
            Category(id: 1, iconName: "code", title: "Coding"),
            Category(id: 2, iconName: "design", title: "Design"),
            Category(id: 3, iconName: "marketing", title: "Marketing"),
            Category(id: 1, iconName: "code", title: "Coding"),
            Category(id: 2, iconName: "design", title: "Design"),
            Category(id: 3, iconName: "marketing", title: "Marketing"),
          ]
        },
      ),
      isEnabled: false,
      prefixIcon: TablerIcons.search,
      suffixIcon: TablerIcons.adjustments_horizontal,
      hint: "Search your course ...",
    );
  }
}
