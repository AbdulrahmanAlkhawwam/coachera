import 'package:coachera/features/home/domain/entities/card_type.dart';
import 'package:coachera/features/instructor/presentation/widgets/instructor_card.dart';
import 'package:coachera/features/search/domain/entities/entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';

import '../../../../core/components/custom_input.dart';
import '../../../../core/components/tag_item.dart';
import '../../../../core/constants/routes.dart';
import '../../../../core/utils/app_context.dart';
import '../../../category/presentation/bloc/bloc/category_bloc.dart';
import '../../../course/domain/entities/course.dart';
import '../../../course/presentation/bloc/bloc/course_bloc.dart';
import '../../../course/presentation/widgets/course_card.dart';
import '../../../home/domain/param/list_param.dart';
import '../../../home/domain/param/sort_param.dart';
import '../../../home/presentation/widgets/courses_list.dart';
import '../../../instructor/domain/entities/instructor.dart';
import '../../../review/domain/entities/review.dart';
import '../../../review/presentation/widgets/review_card.dart';
import '../../domain/params/search_param.dart';
import '../bloc/search_bloc.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({
    super.key,
  });

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  String? selectedEntityId;
  int? selectedCategoryId;

  @override
  void initState() {
    context.read<SearchBloc>()
      ..add(Search(
          param: SearchParam(
        entity: Entity(id: "", name: ""),
        param: ListParam(page: 0, sort: SortParam()),
        input: "",
      )))
      ..add(GetEntities());
    context.read<CategoryBloc>().add(GetCategoryPaginated(
          param: ListParam(page: 0, sort: SortParam()),
        ));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Explore"),
      ),
      body: BlocBuilder<SearchBloc, SearchState>(
        builder: (context, state) {
          final screenItem = [
            CustomInput(
              onChanged: (value) => context.read<SearchBloc>().add(Search(
                      param: SearchParam(
                    param: ListParam(page: 0, sort: SortParam()),
                    input: value,
                    entity: context
                        .read<SearchBloc>()
                        .state
                        .entities
                        .where((element) => element.name == selectedEntityId)
                        .first,
                  ))),
              isEnabled: true,
              prefixIcon: TablerIcons.search,
              suffixIcon: TablerIcons.adjustments_horizontal,
              hint: "Search your course ...",
            ),
            if (context.read<SearchBloc>().state.output.isNotEmpty)
              BlocBuilder<SearchBloc, SearchState>(
                builder: (context, state) => Row(
                  children: [
                    Text("All Result"),
                    const Spacer(),
                    TextButton(
                      onPressed: () => context.push(switch (state.entities
                          .where((element) => element.name == selectedEntityId)
                          .first
                          .name) {
                        "courses" => Routes.courseSearch,
                        "reviews" => Routes.reviews,
                        "instructors" => Routes.instructors,
                        "learning-paths" => Routes.learningPaths,
                        // "materials" => Routes.materials,
                        // "categories" => Routes.categories,
                        _ => Routes.home,
                        // Routes.searchs,
                      },),
                      child: Text("See All"),
                    ),
                  ],
                ),
              ),
            if (context.read<SearchBloc>().state.output.isNotEmpty)
              BlocBuilder<SearchBloc, SearchState>(
                builder: (context, state) => SizedBox(
                  height: context.height / 3,
                  child: ListView.separated(
                    itemBuilder: (context, index) => switch (state.entities
                            .where(
                                (element) => element.name == selectedEntityId)
                            .firstOrNull
                            ?.name ??
                        "") {
                      "courses" => CourseCard(
                          type: CardType.horizontal,
                          course: state.output[index] as Course,
                        ),
                      "reviews" =>
                        ReviewCard(review: state.output[index] as Review),
                      "instructors" => InstructorCard(
                          cardType: CardType.horizontal,
                          instructor: state.output[index] as Instructor,
                        ),
                      // "learning-paths" => LearningPathModel.fromJson(e),
                      // "materials" => MaterialModel.fromJson(e),
                      "categories" => TagItem(
                          text: state.output[index].title,
                          isSelected: false,
                          onSelect: (_) {},
                        ),
                      _ => state.output.isEmpty
                          ? const SizedBox()
                          : ListTile(
                              title: state.output[index],
                            ),
                    },
                    separatorBuilder: (context, index) =>
                        const SizedBox(height: 8),
                    itemCount: state.output.length,
                  ),
                ),
              ),
            const Text(
              "Search by Entity",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            BlocBuilder<SearchBloc, SearchState>(
              builder: (context, state) => Wrap(
                spacing: 8,
                runSpacing: 8,
                children: state.entities.map((entity) {
                  final isSelected = selectedEntityId == entity.id;
                  return TagItem(
                    isSelected: isSelected,
                    onSelect: (_) => setState(() {
                      context.read<SearchBloc>().add(Search(
                              param: SearchParam(
                            entity: entity,
                            param: ListParam(page: 0, sort: SortParam()),
                            input: "",
                          )));
                      selectedEntityId = entity.id;
                    }),
                    text: entity.name,
                  );
                }).toList(),
              ),
            ),
            const Text(
              "Search by Categories",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            BlocBuilder<CategoryBloc, CategoryState>(
              builder: (context, state) => state.categories.isNotEmpty ||
                      state.status == CategoryStatus.loading
                  ? Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: state.categories.map((entity) {
                        final isSelected = selectedCategoryId == entity.id;
                        return TagItem(
                          isSelected: isSelected,
                          onSelect: (_) =>
                              setState(() => selectedCategoryId = entity.id),
                          text: entity.title,
                        );
                      }).toList(),
                    )
                  : const SizedBox(),
            ),
            BlocBuilder<CourseBloc, CourseState>(
              builder: (context, state) => state.courses.isNotEmpty ||
                      state.status == CourseStatus.loading
                  ? CoursesList(
                      loading: state.status == CourseStatus.loading,
                      courses: state.courses,
                    )
                  : const SizedBox(),
            ),
          ];
          return ListView.separated(
            shrinkWrap: true,
            padding: EdgeInsets.only(
              bottom: 12.0 + context.bottomInsets + context.bottomPadding,
              top: 12.0,
              left: 12.0,
              right: 12.0,
            ),
            itemBuilder: (context, index) => screenItem[index],
            separatorBuilder: (context, index) => const SizedBox(height: 24),
            itemCount: screenItem.length,
          );
        },
      ),
    );
  }
}
