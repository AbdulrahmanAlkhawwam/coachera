import 'package:coachera/core/utils/app_context.dart';
import 'package:flutter/material.dart';

import '../../../category/domain/entities/category.dart';
import '../../../category/presentation/widgets/category_card.dart';

class CategoriesList extends StatelessWidget {
  const CategoriesList({
    super.key,
    required this.categories,
    required this.loading,
  });

  final bool loading;

  final List<Category> categories;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 200,
      child: GridView.builder(
        itemCount: loading ? 8 : categories.length + 1,
        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: MediaQuery.of(context).size.width / 4,
          mainAxisExtent: 96,
          mainAxisSpacing: 16,
          crossAxisSpacing: MediaQuery.of(context).size.width / 22,
          childAspectRatio: 1,
        ),
        itemBuilder: (context, index) => index != categories.length && !loading
            ? CategoryCard(
                loading: loading,
                category: categories[index],
                color: context.colors.primary,
              )
            : CategoryCard(
                loading: loading,
                category: Category(
                  id: 0,
                  title: "more",
                  iconName: "category_2",
                ),
                color: context.colors.secondary,
              ),
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
      ),
    );
  }
}
