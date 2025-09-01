import 'package:coachera/core/constants/strings.dart';
import 'package:coachera/core/utils/app_context.dart';
import 'package:coachera/features/home/domain/entities/card_type.dart';
import 'package:coachera/features/organization/presentation/widgets/organization_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import '../../../../core/constants/routes.dart';
import '../../../home/domain/param/list_param.dart';
import '../../../home/domain/param/sort_param.dart';
import '../../../home/presentation/widgets/filter_sheet.dart';
import '../../domain/entities/organization.dart';
import '../bloc/bloc/organization_bloc.dart';

class OrganizationsScreen extends StatefulWidget {
  const OrganizationsScreen({super.key});

  @override
  State<OrganizationsScreen> createState() => _OrganizationsScreenState();
}

class _OrganizationsScreenState extends State<OrganizationsScreen> {
  final PagingController<int, Organization> _pagingController =
      PagingController(firstPageKey: 0);

  @override
  void initState() {
    super.initState();
    _pagingController.addPageRequestListener((pageKey) {
      context.read<OrganizationBloc>().add(
          GetOrganizations(param: ListParam(page: pageKey, sort: SortParam())));
    });
  }

  @override
  void dispose() {
    _pagingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<OrganizationBloc, OrganizationState>(
      listener: (context, state) {
        if (state.status == OrganizationStatus.success) {
          final startIndex = state.page * pageSize;
          final newItems =
              state.organizations.skip(startIndex).take(pageSize).toList();

          final isLastPage = newItems.length < pageSize;

          if (isLastPage) {
            _pagingController.appendLastPage(newItems);
          } else {
            final nextPageKey = state.page + 1;
            _pagingController.appendPage(newItems, nextPageKey);
          }
        } else if (state.status == OrganizationStatus.error) {
          _pagingController.error = state.message!.value;
          context.showErrorSnackBar(massage: state.message);
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: const Text("Organizations"),
            actions: [
              IconButton(
                onPressed: () => showModalBottomSheet(
                  isScrollControlled: true,
                  useSafeArea: true,
                  builder: (context) => FilterSheet(
                      // todo : don't forget to add this
                      sortOptions: ["name"],
                      onFilter: (filter) =>
                          context.read<OrganizationBloc>().add(GetOrganizations(
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
            child: PagedListView<int, Organization>(
              pagingController: _pagingController,
              builderDelegate: PagedChildBuilderDelegate<Organization>(
                itemBuilder: (context, item, index) => Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: OrganizationCard(
                    loading: false,
                    cardType: CardType.horizontal,
                    organization: item,
                  ),
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
