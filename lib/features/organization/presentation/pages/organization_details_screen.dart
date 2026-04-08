import 'package:flutter/material.dart' hide MaterialType;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';
import '../../../../core/utils/app_context.dart';
import '../../../course/presentation/bloc/bloc/course_bloc.dart';
import '../../../course/presentation/widgets/course_card.dart';
import '../../../course/presentation/widgets/course_description.dart';
import '../../../home/domain/entities/card_type.dart';
import '../../../home/presentation/manager/favorite_bloc/favorite_bloc.dart';
import '../../../module/presentation/bloc/bloc/module_bloc.dart';
import '../../../review/presentation/bloc/bloc/review_bloc.dart';
import '../../domain/entities/organization.dart';

class OrganizationDetailsScreen extends StatefulWidget {
  const OrganizationDetailsScreen({
    super.key,
    required this.organization,
  });

  final Organization organization;

  @override
  State<OrganizationDetailsScreen> createState() =>
      _OrganizationDetailsScreenState();
}

class _OrganizationDetailsScreenState extends State<OrganizationDetailsScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    context
        .read<FavoriteBloc>()
        .add(GetFavorite(courseId: widget.organization.id));
    context
        .read<ReviewBloc>()
        .add(GetCourseReview(courseId: widget.organization.id));
    context
        .read<ModuleBloc>()
        .add(GetModules(courseId: widget.organization.id));
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.canPop(context) ? context.pop() : null,
          icon: Icon(TablerIcons.chevron_left),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(TablerIcons.share),
          )
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                widget.organization.orgName,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: context.textTheme.titleLarge,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: [],
                        ),
                        const SizedBox(height: 12),
                      ],
                    ),
                  ),
                  TabBar(
                    controller: _tabController,
                    tabs: const [
                      Tab(text: "Details"),
                      Tab(text: "Lessons"),
                      Tab(text: "Learning Paths"),
                    ],
                  ),
                  Expanded(
                    child: TabBarView(
                      controller: _tabController,
                      children: <Widget>[
                        _buildDetailsTab(),
                        _buildCoursesTab(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailsTab() {
    return Padding(
      padding: EdgeInsets.all(16.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CourseDescription(
              title: "About this Organization",
              body: widget.organization.orgDescription,
            ),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }

  Widget _buildCoursesTab() {
    return BlocBuilder<CourseBloc, CourseState>(
      builder: (context, state) => state.status == CourseStatus.loading
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: state.courses.length,
              itemBuilder: (context, index) => CourseCard(
                    course: state.courses[index],
                    loading: state.status == CourseStatus.loading,
                    type: CardType.horizontal,
                  )),
    );
  }
}
