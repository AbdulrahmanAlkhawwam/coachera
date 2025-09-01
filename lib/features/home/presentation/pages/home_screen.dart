import 'package:coachera/core/components/bounded_list.dart';
import 'package:coachera/core/constants/routes.dart';
import 'package:coachera/core/utils/app_context.dart';
import 'package:coachera/core/utils/app_image.dart';
import 'package:coachera/features/auth/presentation/manager/bloc/auth_bloc.dart';
import 'package:coachera/features/category/presentation/bloc/bloc/category_bloc.dart';
import 'package:coachera/features/home/domain/param/list_param.dart';
import 'package:coachera/features/home/domain/param/sort_param.dart';
import 'package:coachera/features/home/presentation/manager/notification_bloc/notification_bloc.dart';
import 'package:coachera/features/home/presentation/widgets/courses_list.dart';
import 'package:coachera/features/home/presentation/widgets/organizations_list.dart';
import 'package:coachera/features/organization/presentation/bloc/bloc/organization_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/components/learning_path_card.dart';
import '../../../../core/constants/res.dart';
import '../../../course/presentation/bloc/bloc/course_bloc.dart';
import '../../../instructor/presentation/bloc/bloc/instructor_bloc.dart';
import '../widgets/categories_list.dart';
import '../../../search/presentation/widgets/search_card.dart';
import '../widgets/instructor_list.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    context.read<AuthBloc>().add(GetMe());
    if (context.read<InstructorBloc>().state.instructors.isEmpty) {
      context
          .read<InstructorBloc>()
          .add(GetInstructors(param: ListParam(page: 0, sort: SortParam())));
    }
    if (context.read<CategoryBloc>().state.categories.isEmpty) {
      context.read<CategoryBloc>().add(
          GetCategoryPaginated(param: ListParam(page: 0, sort: SortParam())));
    }
    if (context.read<CourseBloc>().state.courses.isEmpty) {
      context.read<CourseBloc>().add(
          GetRecommendedCourses(param: ListParam(page: 0, sort: SortParam())));
    }
    if (context.read<OrganizationBloc>().state.organizations.isEmpty) {
      context
          .read<OrganizationBloc>()
          .add(GetOrganizations(param: ListParam(page: 0, sort: SortParam())));
    }
    super.initState();
  }

  Future<void> _refreshData() async {
    // Always fetch fresh data (don’t depend on empty check)
    context.read<AuthBloc>().add(GetMe());
    context
        .read<InstructorBloc>()
        .add(GetInstructors(param: ListParam(page: 0, sort: SortParam())));
    context.read<CategoryBloc>().add(
        GetCategoryPaginated(param: ListParam(page: 0, sort: SortParam())));
    context.read<CourseBloc>().add(
        GetRecommendedCourses(param: ListParam(page: 0, sort: SortParam())));
    context
        .read<OrganizationBloc>()
        .add(GetOrganizations(param: ListParam(page: 0, sort: SortParam())));

    // small delay so RefreshIndicator knows work finished
    await Future.delayed(const Duration(milliseconds: 500));
  }

  @override
  Widget build(BuildContext context) {
    final screenItem = [
      SearchCard(),
      BlocBuilder<CategoryBloc, CategoryState>(
        builder: (context, state) => state.categories.isNotEmpty ||
                state.status == CategoryStatus.loading
            ? CategoriesList(
                loading: state.status == CategoryStatus.loading,
                categories: state.categories,
              )
            : const SizedBox(),
      ),
      BlocBuilder<CourseBloc, CourseState>(
        builder: (context, state) =>
            state.courses.isNotEmpty || state.status == CourseStatus.loading
                ? CoursesList(
                    loading: state.status == CourseStatus.loading,
                    courses: state.courses,
                  )
                : const SizedBox(),
      ),
      LearningPathCard(onTap: () => context.push(Routes.learningPaths)),
      BlocBuilder<OrganizationBloc, OrganizationState>(
        builder: (context, state) => state.organizations.isNotEmpty ||
                state.status == OrganizationStatus.loading
            ? OrganizationsList(
                loading: state.status == OrganizationStatus.loading,
                organizations: state.organizations,
              )
            : const SizedBox(),
      ),
      BlocBuilder<InstructorBloc, InstructorState>(
        builder: (context, state) => state.instructors.isNotEmpty ||
                state.status == InstructorStatus.loading
            ? InstructorList(
                loading: state.status == InstructorStatus.loading,
                instructors: state.instructors,
              )
            : const SizedBox(),
      ),
      // Container(
      //   height: context.height / 5,
      //   decoration: const BoxDecoration(
      //     gradient: LinearGradient(
      //       colors: [
      //         Color(0xFF20C997),
      //         Color(0xFF18B4AC),
      //       ],
      //       begin: Alignment.topLeft,
      //       end: Alignment.bottomRight,
      //     ),
      //     borderRadius: BorderRadius.all(Radius.circular(16)),
      //   ),
      //   child: Container(
      //     margin: EdgeInsets.all(4),
      //     decoration: BoxDecoration(
      //       color: context.colors.primaryContainer,
      //       borderRadius: BorderRadius.all(Radius.circular(12)),
      //     ),
      //     child: Container(
      //       margin: EdgeInsets.all(4),
      //       decoration: BoxDecoration(
      //         gradient: LinearGradient(
      //           colors: [
      //             Color(0xFF20C997),
      //             Color(0xFF18B4AC),
      //           ],
      //           begin: Alignment.topLeft,
      //           end: Alignment.bottomRight,
      //         ),
      //         borderRadius: BorderRadius.all(Radius.circular(8)),
      //       ),
      //       child: Stack(
      //         // mainAxisSize: MainAxisSize.min,
      //         children: [
      //           Align(
      //             alignment: Alignment.bottomLeft,
      //             child: AppImage(Res.learningPathAds),
      //           ),
      //           Padding(
      //             padding: const EdgeInsets.all(16),
      //             child: Text(
      //               "Learning Path\nis Available Now",
      //               style: context.textTheme.displaySmall?.copyWith(
      //                 color: context.colors.surface,
      //                 fontFamily: GoogleFonts.laBelleAurore(
      //                   fontWeight: FontWeight.w600,
      //                 ).fontFamily,
      //               ),
      //             ),
      //           ),
      //         ],
      //       ),
      //     ),
      //   ),
      // ),
      // FilledButton(
      //     onPressed: () => context.push(Routes.instructors),
      //     child: Text("instructors"))
    ];
    return RefreshIndicator(
      onRefresh: _refreshData,
      child: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state.status == AuthStatus.error && state.message!.code == 401) {
            context.pushReplacement(Routes.login);
            context.showErrorSnackBar(massage: state.message);
          }
        },
        child: Scaffold(
          appBar: AppBar(
            title: Text(
                "Hi , ${context.read<AuthBloc>().state.user?.firstName ?? "Guest"}"),
            actions: [
              BlocBuilder<NotificationBloc, NotificationState>(
                builder: (context, state) => IconButton(
                  onPressed: () async => context.push(Routes.notification),
                  icon: Icon(
                    state.unreadNotification != 0
                        ? TablerIcons.bell_ringing_filled
                        : TablerIcons.bell_ringing,
                    color: state.unreadNotification != 0
                        ? context.colors.secondary
                        : null,
                  ),
                ),
              )
            ],
          ),
          body: ListView.separated(
            shrinkWrap: true,
            padding: EdgeInsets.all(16),
            itemBuilder: (context, index) => screenItem[index],
            separatorBuilder: (context, index) => const SizedBox(height: 24),
            itemCount: screenItem.length,
          ),
        ),
      ),
    );
  }
}
/* await showModalBottomSheet(
                  isScrollControlled: true,
                  useSafeArea: true,
                  builder: (context) => FilterSheet(
                    starsLength: 3,
                    onFilter: (filterData) => print(filterData),
                    categories: [
                      Category(id: 1, iconName: "code", title: "Coding"),
                      Category(id: 2, iconName: "design", title: "Design"),
                      Category(id: 3, iconName: "marketing", title: "Marketing"),
                    ],
                    priceRanges: ["\$10 - \$50", "\$50 - \$100", "\$100 - \$150"],
                  ),
                  context: context,
                ),*/
