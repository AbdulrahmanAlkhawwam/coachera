import 'package:coachera/core/utils/app_context.dart';
import 'package:flutter/material.dart';

import '../../../category/domain/entities/category.dart';
import '../../../category/presentation/widgets/category_card.dart';

class CategoriesList extends StatelessWidget {
  const CategoriesList({super.key, required this.categories});

  final List<Category> categories;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 240,
      child: GridView.builder(
        itemCount: 8,
        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: MediaQuery.of(context).size.width / 4,
          mainAxisExtent: 96,
          mainAxisSpacing: 16,
          crossAxisSpacing: 16,
          childAspectRatio: 1,
        ),
        itemBuilder: (context, index) => index != 7
            ? CategoryCard(
                category: categories[index],
                color:
                    index % 2 == 1 && index <= 4 || index % 2 == 0 && index > 3
                        ? context.colors.primary
                        : context.colors.secondary,
              )
            : CategoryCard(
                category: Category(
                  id: 0,
                  title: "more",
                  iconName: "category_2",
                ),
                color:
                    index % 2 == 1 && index <= 4 || index % 2 == 0 && index > 3
                        ? context.colors.primary
                        : context.colors.secondary,
              ),
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
      ),
    );
  }
}
