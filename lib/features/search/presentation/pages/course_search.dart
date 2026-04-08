import 'package:coachera/core/constants/strings.dart';
import 'package:coachera/core/utils/app_context.dart';
import 'package:coachera/features/course/presentation/widgets/course_card.dart';
import 'package:coachera/features/home/domain/entities/card_type.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import '../../../course/domain/entities/course.dart';
import '../../domain/params/search_param.dart';
import '../bloc/search_bloc.dart';

class CourseSearch extends StatefulWidget {
  final SearchParam searchParam;

  const CourseSearch({
    super.key,
    required this.searchParam,
  });

  @override
  State<CourseSearch> createState() => _CourseSearchState();
}

class _CourseSearchState extends State<CourseSearch> {
  final PagingController<int, Course> _pagingController =
      PagingController(firstPageKey: 0);

  @override
  void initState() {
    super.initState();
    _pagingController.addPageRequestListener((pageKey) {
      context
          .read<SearchBloc>()
          .add(GetSearchCourses(param: widget.searchParam));
    });
  }

  @override
  void dispose() {
    _pagingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SearchBloc, SearchState>(
      listener: (context, state) {
        if (state.status == SearchStatus.success) {
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
        } else if (state.status == SearchStatus.error) {
          _pagingController.error = state.message!.value;
          context.showErrorSnackBar(massage: state.message);
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: const Text("Searched Courses"),
            // actions: [
            //   IconButton(
            //     onPressed: () => showModalBottomSheet(
            //       isScrollControlled: true,
            //       useSafeArea: true,
            //       builder: (context) => FilterSheet(
            //         todo : don't forget to add this
            // sortOptions: ["name"],
            // onFilter: (filter) =>
            //     context.read<CourseBloc>().add(GetRecommendedCourses(
            //         param: ListParam(
            //           sort: SortParam(
            //             sortDirection: filter.sortType,
            //             sortBy: filter.sortBy,
            //           ),
            //           page: 0,
            //         )))),
            // context: context,
            // ),
            // icon: Icon(TablerIcons.adjustments_horizontal),
            // )
            // ],
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
