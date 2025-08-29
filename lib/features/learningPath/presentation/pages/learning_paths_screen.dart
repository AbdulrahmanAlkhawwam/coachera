import 'package:coachera/core/utils/app_context.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import '../../../../core/constants/routes.dart';
import '../../../../core/constants/strings.dart';
import '../../../home/domain/param/list_param.dart';
import '../../../home/domain/param/sort_param.dart';
import '../../../home/presentation/widgets/filter_sheet.dart';
import '../../domain/entities/learning_path.dart';
import '../bloc/bloc/learning_path_bloc.dart';

class LearningPathsScreen extends StatefulWidget {
  const LearningPathsScreen({super.key});

  @override
  State<LearningPathsScreen> createState() => _LearningPathsScreenState();
}

class _LearningPathsScreenState extends State<LearningPathsScreen> {
  final PagingController<int, LearningPath> _pagingController =
      PagingController(firstPageKey: 0);

  @override
  void initState() {
    super.initState();
    _pagingController.addPageRequestListener((pageKey) {
      context.read<LearningPathBloc>().add(
          GetLearningPaths(param: ListParam(page: pageKey, sort: SortParam())));
    });
  }

  @override
  void dispose() {
    _pagingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LearningPathBloc, LearningPathState>(
      listener: (context, state) {
        if (state.status == LearningPathStatus.success) {
          final startIndex = state.page * pageSize;
          final newItems =
              state.learningPath.skip(startIndex).take(pageSize).toList();

          final isLastPage = newItems.length < pageSize;

          if (isLastPage) {
            _pagingController.appendLastPage(newItems);
          } else {
            final nextPageKey = state.page + 1;
            _pagingController.appendPage(newItems, nextPageKey);
          }
        } else if (state.status == LearningPathStatus.error) {
          _pagingController.error = state.message!.value;
          context.showErrorSnackBar(massage: state.message);
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: const Text("Instructors"),
            actions: [
              IconButton(
                onPressed: () => showModalBottomSheet(
                  isScrollControlled: true,
                  useSafeArea: true,
                  builder: (context) => FilterSheet(
                      // todo : don't forget to add this
                      sortOptions: ["name"],
                      onFilter: (filter) =>
                          context.read<LearningPathBloc>().add(GetLearningPaths(
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
            child: PagedListView<int, LearningPath>(
              pagingController: _pagingController,
              builderDelegate: PagedChildBuilderDelegate<LearningPath>(
                itemBuilder: (context, item, index) => ListTile(
                  onTap: () => context.push(Routes.instructor),
                  leading: CircleAvatar(child: Text(item.id.toString())),
                  title: Text(item.title),
                  subtitle: Text(item.description,
                      style: context.textTheme.bodyMedium?.copyWith(
                          color: context.colors.outlineVariant.withAlpha(120))),
                ),
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
