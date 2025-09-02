import 'package:coachera/features/course/presentation/widgets/course_card.dart';
import 'package:coachera/features/home/domain/entities/card_type.dart';
import 'package:coachera/features/home/presentation/widgets/instructor_list.dart';
import 'package:coachera/features/home/presentation/widgets/organizations_list.dart';
import 'package:coachera/features/instructor/presentation/bloc/bloc/instructor_bloc.dart';
import 'package:coachera/features/instructor/presentation/widgets/instructor_card.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart' hide MaterialType;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../core/components/list_tile_item.dart';
import '../../../../core/components/rate.dart';
import '../../../../core/constants/routes.dart';
import '../../../../core/utils/app_context.dart';
import '../../../../core/utils/app_image.dart';
import '../../../course/presentation/bloc/bloc/course_bloc.dart';
import '../../../course/presentation/widgets/course_description.dart';
import '../../../home/presentation/manager/favorite_bloc/favorite_bloc.dart';
import '../../../material/domain/entities/material_type.dart';
import '../../../module/presentation/bloc/bloc/module_bloc.dart';
import '../../../material/data/model/material_model.dart';
import '../../../organization/presentation/bloc/bloc/organization_bloc.dart';
import '../../../organization/presentation/widgets/organization_card.dart';
import '../../../review/presentation/bloc/bloc/review_bloc.dart';
import '../../../review/presentation/widgets/review_card.dart';
import '../../domain/entities/learning_path.dart';

class LearningPathDetailsScreen extends StatefulWidget {
  const LearningPathDetailsScreen({super.key, required this.learningPath});

  final LearningPath learningPath;

  @override
  State<LearningPathDetailsScreen> createState() =>
      _LearningPathDetailsScreenState();
}

class _LearningPathDetailsScreenState extends State<LearningPathDetailsScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  String? _expandedIndex;

  @override
  void initState() {
    super.initState();
    // context
    //     .read<FavoriteBloc>()
    //     .add(GetFavorite(courseId: widget.learningPath.id));
    context
        .read<ReviewBloc>()
        .add(GetCourseReview(courseId: widget.learningPath.id));
    // context
    //     .read<ModuleBloc>()
    //     .add(GetModules(courseId: widget.learningPath.id));
    context
        .read<InstructorBloc>()
        .add(GetCourseInstructors(courseId: widget.learningPath.id));
    context
        .read<OrganizationBloc>()
        .add(GetOrganization(orgId: widget.learningPath.orgId));
    _tabController = TabController(length: 2, vsync: this);
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
            AppImage(
              widget.learningPath.imageUrl,
              fit: BoxFit.cover,
              width: double.infinity,
            ),
            Expanded(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.learningPath.title,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: context.textTheme.headlineLarge,
                        ),
                        Row(
                          children: [
                            // Rate(rate: widget.learningPath.rating * 2.round() / 2),
                            // const SizedBox(width: 4),
                            // Text(widget.learningPath.imageUrl),
                            // const SizedBox(width: 8),
                            // Text(
                            //     widget.learningPath.instructors.length > 1
                            //         ? "By Some Instructors"
                            //         : widget.learningPath.instructors.firstOrNull ==
                            //                 null
                            //             ? ''
                            //             : "by ${context.read<InstructorBloc>().state.instructors.firstOrNull?.name}",
                            //     style: context.textTheme.bodyMedium?.copyWith(
                            //       color: context.colors.primary,
                            //       fontWeight: FontWeight.w600,
                            //     )),
                          ],
                        ),
                        // const SizedBox(height: 12),
                        // /Row(
                        //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        //   children: [
                        //     Text("${widget.learningPath.price} \$",
                        //         style: context.textTheme.titleMedium?.copyWith(
                        //           color: context.colors.primary,
                        //         )),
                        //     Text(widget.learningPath.durationHours,
                        //         style: context.textTheme.bodyMedium?.copyWith(
                        //           color: context.colors.outlineVariant
                        //               .withAlpha(160),
                        //         )),
                        //   ],
                        // ),
                      ],
                    ),
                  ),
                  TabBar(
                    controller: _tabController,
                    tabs: const [
                      Tab(text: "Details"),
                      Tab(text: "Courses"),
                      // Tab(text: "Reviews"),
                    ],
                  ),
                  Expanded(
                    child: TabBarView(
                      controller: _tabController,
                      children: <Widget>[
                        _buildDetailsTab(),
                        _buildCoursesTab(),
                        // _buildReviewsTab(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.only(
            left: 24.0,
            right: 24.0,
            top: 16,
            bottom: 16 + context.bottomPadding),
        // child: FilledButton(
        //   onPressed: () => context
        //       .read<CourseBloc>()
        //       .add(EnrollCourse(courseId: widget.learningPath.id)),
        //   child: const Text("Enroll Now"),
        // ),
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
              title: "About Learning Path ",
              body: widget.learningPath.description,
            ),
            BlocBuilder<OrganizationBloc, OrganizationState>(
              builder: (context, state) => Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    child: Text("Learning Path Organizations",
                        style: context.textTheme.titleSmall),
                  ),
                  OrganizationCard(
                    cardType: CardType.horizontal,
                    organization: state.organization,
                    loading: state.status == OrganizationStatus.loading,
                  ),
                ],
              ),
            ),
            BlocBuilder<InstructorBloc, InstructorState>(
              builder: (context, state) => state.instructors.length == 1
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          child: Text("Learning Path Instructors",
                              style: context.textTheme.titleSmall),
                        ),
                        InstructorCard(
                          cardType: CardType.horizontal,
                          instructor: state.instructors.first,
                          loading: state.status == InstructorStatus.loading,
                        ),
                      ],
                    )
                  : InstructorList(
                      showMore: false,
                      instructors: state.instructors,
                      loading: state.status == InstructorStatus.loading,
                    ),
            ),
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
              // padding: const EdgeInsets.all(16),
              itemCount: state.courses.length,
              itemBuilder: (context, index) => CourseCard(
                    course: state.courses[index],
                    loading: state.status == CourseStatus.loading,
                    type: CardType.horizontal,
                  )),
    );
  }

  Widget _buildReviewsTab() {
    return BlocBuilder<ReviewBloc, ReviewState>(
      builder: (context, state) => state.status == ReviewStatus.loading
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: state.reviews.length,
              itemBuilder: (context, index) =>
                  ReviewCard(review: state.reviews[index])),
    );
  }
}
