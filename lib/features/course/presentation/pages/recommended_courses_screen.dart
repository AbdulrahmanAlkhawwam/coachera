import 'package:coachera/core/constants/strings.dart';
import 'package:coachera/core/utils/app_context.dart';
import 'package:coachera/features/course/presentation/widgets/course_card.dart';
import 'package:coachera/features/home/domain/entities/card_type.dart';
import 'package:coachera/features/home/domain/param/sort_param.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import '../../../home/domain/param/list_param.dart';
import '../../../home/presentation/widgets/filter_sheet.dart';
import '../../domain/entities/course.dart';
import '../bloc/bloc/course_bloc.dart';

class RecommendedCoursesScreen extends StatefulWidget {
  const RecommendedCoursesScreen({super.key});

  @override
  State<RecommendedCoursesScreen> createState() =>
      _RecommendedCoursesScreenState();
}

class _RecommendedCoursesScreenState extends State<RecommendedCoursesScreen> {
  final PagingController<int, Course> _pagingController =
      PagingController(firstPageKey: 0);

  @override
  void initState() {
    super.initState();
    _pagingController.addPageRequestListener((pageKey) {
      context.read<CourseBloc>().add(GetRecommendedCourses(
          param: ListParam(page: pageKey, sort: SortParam())));
    });
  }

  @override
  void dispose() {
    _pagingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CourseBloc, CourseState>(
      listener: (context, state) {
        if (state.status == CourseStatus.success) {
          final startIndex = state.page * pageSize;
          final newItems =
              state.courses.skip(startIndex).take(pageSize).toList();

          final isLastPage = newItems.length < pageSize;

          if (isLastPage) {
            _pagingController.appendLastPage(newItems);
          } else {
            final nextPageKey = state.page + 1;
            _pagingController.appendPage(newItems, nextPageKey);
          }
        } else if (state.status == CourseStatus.error) {
          _pagingController.error = state.message!.value;
          context.showErrorSnackBar(massage: state.message);
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: const Text("Recommended Courses"),
            actions: [
              IconButton(
                onPressed: () => showModalBottomSheet(
                  isScrollControlled: true,
                  useSafeArea: true,
                  builder: (context) => FilterSheet(
                      // todo : don't forget to add this
                      sortOptions: ["name"],
                      onFilter: (filter) =>
                          context.read<CourseBloc>().add(GetRecommendedCourses(
                                  param: ListParam(
                                sort: SortParam(
                                  sortDirection: filter.sortType,
                                  sortBy: filter.sortBy,
                                ),
                                page: 0,
                              )))),
                  context: context,
                ),
                icon: Icon(TablerIcons.adjustments_horizontal),
              )
            ],
          ),
          body: RefreshIndicator(
            onRefresh: () async {
              _pagingController.refresh();
            },
            child: PagedListView<int, Course>(
              pagingController: _pagingController,
              builderDelegate: PagedChildBuilderDelegate<Course>(
                itemBuilder: (context, item, index) =>
                    CourseCard(type: CardType.horizontal, course: item),
                firstPageProgressIndicatorBuilder: (context) =>
                    const Center(child: CircularProgressIndicator()),
                newPageProgressIndicatorBuilder: (context) =>
                    const Center(child: CircularProgressIndicator()),
                noItemsFoundIndicatorBuilder: (context) =>
                    const Center(child: Text("No instructors found")),
              ),
            ),
          ),
        );
      },
    );
  }
}
