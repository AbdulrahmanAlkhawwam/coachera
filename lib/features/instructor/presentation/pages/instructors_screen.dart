import 'package:coachera/core/constants/strings.dart';
import 'package:coachera/core/utils/app_context.dart';
import 'package:coachera/features/home/domain/entities/card_type.dart';
import 'package:coachera/features/home/domain/param/sort_param.dart';
import 'package:coachera/features/instructor/presentation/widgets/instructor_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import '../../../../core/constants/routes.dart';
import '../../../home/domain/param/list_param.dart';
import '../../../home/presentation/widgets/filter_sheet.dart';
import '../../domain/entities/instructor.dart';
import '../bloc/bloc/instructor_bloc.dart';

class InstructorScreen extends StatefulWidget {
  const InstructorScreen({super.key});

  @override
  State<InstructorScreen> createState() => _InstructorScreenState();
}

class _InstructorScreenState extends State<InstructorScreen> {
  final PagingController<int, Instructor> _pagingController =
      PagingController(firstPageKey: 0);

  @override
  void initState() {
    super.initState();
    _pagingController.addPageRequestListener((pageKey) {
      context.read<InstructorBloc>().add(
          GetInstructors(param: ListParam(page: pageKey, sort: SortParam())));
    });
  }

  @override
  void dispose() {
    _pagingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<InstructorBloc, InstructorState>(
      listener: (context, state) {
        if (state.status == InstructorStatus.success) {
          final startIndex = state.page * pageSize;
          final newItems =
              state.instructors.skip(startIndex).take(pageSize).toList();

          final isLastPage = newItems.length < pageSize;

          if (isLastPage) {
            _pagingController.appendLastPage(newItems);
          } else {
            final nextPageKey = state.page + 1;
            _pagingController.appendPage(newItems, nextPageKey);
          }
        } else if (state.status == InstructorStatus.error) {
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
                          context.read<InstructorBloc>().add(GetInstructors(
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
            child: PagedListView<int, Instructor>(
              pagingController: _pagingController,
              builderDelegate: PagedChildBuilderDelegate<Instructor>(
                itemBuilder: (context, item, index) => Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 8.0,
                    horizontal: 16,
                  ),
                  child: InstructorCard(
                    instructor: item,
                    cardType: CardType.horizontal,
                    loading: false,
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

// import 'package:coachera/core/constants/strings.dart';
// import 'package:coachera/core/utils/app_context.dart';
// import 'package:coachera/features/home/domain/param/sort_param.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
//
// import '../../../../core/constants/routes.dart';
// import '../../../home/domain/param/list_param.dart';
// import '../../domain/entities/instructor.dart';
// import '../bloc/bloc/instructor_bloc.dart';
//
// class InstructorScreen extends StatefulWidget {
//   const InstructorScreen({super.key});
//
//   @override
//   State<InstructorScreen> createState() => _InstructorScreenState();
// }
//
// class _InstructorScreenState extends State<InstructorScreen> {
//   final PagingController<int, Instructor> _pagingController =
//       PagingController(firstPageKey: 0);
//
//   @override
//   void initState() {
//     super.initState();
//     _pagingController.addPageRequestListener((pageKey) {
//       context.read<InstructorBloc>().add(GetInstructors(
//             param: ListParam(
//               page: pageKey,
//               sort: SortParam(
//                 sortBy: null,
//                 sortDirection: null,
//               ),
//             ),
//           ));
//     });
//   }
//
//   @override
//   void dispose() {
//     _pagingController.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return BlocConsumer<InstructorBloc, InstructorState>(
//       listener: (context, state) {
//         if (state.status == InstructorStatus.success) {
//           final isLastPage = state.instructors.length < pageSize;
//           if (isLastPage) {
//             _pagingController.appendLastPage(state.instructors);
//           } else {
//             final nextPageKey = state.page + 1;
//             _pagingController.appendPage(state.instructors, nextPageKey);
//           }
//         } else if (state.status == InstructorStatus.error) {
//           _pagingController.error = state.message!.value;
//           context.showErrorSnackBar(massage: state.message);
//         }
//       },
//       builder: (context, state) {
//         return Scaffold(
//           appBar: AppBar(title: const Text("Instructors")),
//           body: RefreshIndicator(
//             onRefresh: () async {
//               _pagingController.refresh(); // 🔄 reloads from first page
//             },
//             child: PagedListView<int, Instructor>(
//               pagingController: _pagingController,
//               builderDelegate: PagedChildBuilderDelegate<Instructor>(
//                 itemBuilder: (context, item, index) => ListTile(
//                   onTap: () => context.push(Routes.instructor),
//                   leading: CircleAvatar(child: Text(item.name[0])),
//                   title: Text(item.name),
//                   subtitle: Text(item.name),
//                 ),
//                 firstPageProgressIndicatorBuilder: (context) =>
//                     const Center(child: CircularProgressIndicator()),
//                 newPageProgressIndicatorBuilder: (context) =>
//                     const Center(child: CircularProgressIndicator()),
//                 noItemsFoundIndicatorBuilder: (context) =>
//                     const Center(child: Text("No instructors found")),
//               ),
//             ),
//           ),
//         );
//       },
//     );
//   }
// }

// import 'package:coachera/core/constants/strings.dart';
// import 'package:coachera/core/utils/app_context.dart';
// import 'package:coachera/features/home/domain/param/sort_param.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';
// import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
//
// import '../../../../core/constants/routes.dart';
// import '../../../home/domain/param/list_param.dart';
// import '../../../home/presentation/widgets/filter_sheet.dart';
// import '../../domain/entities/instructor.dart';
// import '../bloc/bloc/instructor_bloc.dart';
//
// class InstructorScreen extends StatefulWidget {
//   const InstructorScreen({super.key});
//
//   @override
//   State<InstructorScreen> createState() => _InstructorScreenState();
// }
//
// class _InstructorScreenState extends State<InstructorScreen> {
//   final PagingController<int, Instructor> _pagingController =
//       PagingController(firstPageKey: 0);
//
//   @override
//   void initState() {
//     super.initState();
//     _pagingController.addPageRequestListener(
//         (pageKey) => context.read<InstructorBloc>().add(GetInstructors(
//               param: ListParam(
//                 page: pageKey,
//                 sort: SortParam(
//                   sortBy: null,
//                   sortDirection: null,
//                 ),
//               ),
//             )));
//   }
//
//   @override
//   void dispose() {
//     _pagingController.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return BlocConsumer<InstructorBloc, InstructorState>(
//       listener: (context, state) {
//         if (state.status == InstructorStatus.success) {
//           final isLastPage = state.instructors.length < pageSize;
//           if (isLastPage) {
//             _pagingController.appendLastPage(state.instructors);
//           } else {
//             final nextPageKey = state.page + 1;
//             _pagingController.appendPage(state.instructors, nextPageKey);
//           }
//         } else if (state.status == InstructorStatus.error) {
//           _pagingController.error = state.message!.value;
//         }
//       },
//       builder: (context, state) {
//         return Scaffold(
//           appBar: AppBar(
//             title: const Text("Instructors"),
//             actions: [
//               IconButton(
//                 onPressed: () => showModalBottomSheet(
//                   isScrollControlled: true,
//                   useSafeArea: true,
//                   builder: (context) => FilterSheet(
//                       sortOptions: ["name"],
//                       onFilter: (filter) =>
//                           context.read<InstructorBloc>().add(GetInstructors(
//                                   param: ListParam(
//                                 sort: SortParam(
//                                   sortDirection: filter.sortType,
//                                   sortBy: filter.sortBy,
//                                 ),
//                                 page: 0,
//                               )))),
//                   context: context,
//                 ),
//                 icon: Icon(TablerIcons.adjustments_horizontal),
//               )
//             ],
//           ),
//           body: PagedListView<int, Instructor>(
//             pagingController: _pagingController,
//             builderDelegate: PagedChildBuilderDelegate<Instructor>(
//               itemBuilder: (context, item, index) => ListTile(
//                 onTap: () => context.push(Routes.instructor),
//                 leading: CircleAvatar(child: Text(item.name[0])),
//                 title: Text(item.name),
//                 subtitle: Text(item.name),
//               ),
//               firstPageProgressIndicatorBuilder: (context) =>
//                   const Center(child: CircularProgressIndicator()),
//               newPageProgressIndicatorBuilder: (context) =>
//                   const Center(child: CircularProgressIndicator()),
//               noItemsFoundIndicatorBuilder: (context) =>
//                   const Center(child: Text("No instructors found")),
//             ),
//           ),
//         );
//       },
//     );
//   }
// }
