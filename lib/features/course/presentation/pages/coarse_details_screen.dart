import 'package:coachera/features/home/presentation/widgets/organizations_list.dart';
import 'package:coachera/features/instructor/presentation/bloc/bloc/instructor_bloc.dart';
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
import '../../../home/presentation/manager/favorite_bloc/favorite_bloc.dart';
import '../../../material/domain/entities/material_type.dart';
import '../../../module/presentation/bloc/bloc/module_bloc.dart';
import '../../../material/data/model/material_model.dart';
import '../../../organization/presentation/bloc/bloc/organization_bloc.dart';
import '../../../organization/presentation/widgets/organization_card.dart';
import '../../../review/presentation/bloc/bloc/review_bloc.dart';
import '../../../review/presentation/widgets/review_card.dart';
import '../../domain/entities/course.dart';
import '../bloc/bloc/course_bloc.dart';
import '../widgets/course_description.dart';

class CourseDetailsScreen extends StatefulWidget {
  const CourseDetailsScreen({super.key, required this.course});

  final Course course;

  @override
  State<CourseDetailsScreen> createState() => _CourseDetailsScreenState();
}

class _CourseDetailsScreenState extends State<CourseDetailsScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  String? _expandedIndex;

  @override
  void initState() {
    super.initState();
    context.read<FavoriteBloc>().add(GetFavorite(courseId: widget.course.id));
    context.read<ReviewBloc>().add(GetCourseReview(courseId: widget.course.id));
    context.read<ModuleBloc>().add(GetModules(courseId: widget.course.id));
    context
        .read<InstructorBloc>()
        .add(GetCourseInstructors(courseId: widget.course.id));
    context
        .read<OrganizationBloc>()
        .add(GetOrganization(orgId: widget.course.orgId));
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
            AppImage(
              widget.course.image,
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
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                widget.course.title,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: context.textTheme.titleLarge,
                              ),
                            ),
                            BlocConsumer<FavoriteBloc, FavoriteState>(
                              listener: (context, state) {
                                if (state.status == FavoriteStatus.error) {
                                  context.showErrorSnackBar(
                                      massage: state.message);
                                }
                              },
                              builder: (context, state) => IconButton(
                                onPressed: () => state.isFavorite ?? false
                                    ? context.read<FavoriteBloc>().add(
                                        DeleteFavorite(
                                            courseId: widget.course.id))
                                    : context.read<FavoriteBloc>().add(
                                        AddFavorite(
                                            courseId: widget.course.id)),
                                icon: state.status == FavoriteStatus.loading
                                    ? Shimmer.fromColors(
                                        baseColor: context.colors.outline,
                                        highlightColor:
                                            context.colors.outlineVariant,
                                        child: Icon(TablerIcons.heart_filled),
                                      )
                                    : Icon(
                                        state.isFavorite ?? true
                                            ? TablerIcons.heart_filled
                                            : TablerIcons.heart,
                                        color: state.isFavorite ?? false
                                            ? context.colors.error
                                            : null,
                                      ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            Rate(rate: widget.course.rating * 2.round() / 2),
                            const SizedBox(width: 4),
                            Text(widget.course.rating.toString()),
                            const SizedBox(width: 8),
                            Text(
                                widget.course.instructors.length > 1
                                    ? "By Some Instructors"
                                    : widget.course.instructors.firstOrNull ==
                                            null
                                        ? ''
                                        : "by ${context.read<InstructorBloc>().state.instructors.firstOrNull?.name}",
                                style: context.textTheme.bodyMedium?.copyWith(
                                  color: context.colors.primary,
                                  fontWeight: FontWeight.w600,
                                )),
                          ],
                        ),
                        const SizedBox(height: 12),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("${widget.course.price} \$",
                                style: context.textTheme.titleMedium?.copyWith(
                                  color: context.colors.primary,
                                )),
                            Text(widget.course.durationHours,
                                style: context.textTheme.bodyMedium?.copyWith(
                                  color: context.colors.outlineVariant
                                      .withAlpha(160),
                                )),
                          ],
                        ),
                      ],
                    ),
                  ),
                  TabBar(
                    controller: _tabController,
                    tabs: const [
                      Tab(text: "Details"),
                      Tab(text: "Lessons"),
                      Tab(text: "Reviews"),
                    ],
                  ),
                  Expanded(
                    child: TabBarView(
                      controller: _tabController,
                      children: <Widget>[
                        _buildDetailsTab(),
                        _buildLessonsTab(),
                        _buildReviewsTab(),
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
        child: FilledButton(
          onPressed: () => context
              .read<CourseBloc>()
              .add(EnrollCourse(courseId: widget.course.id)),
          child: const Text("Enroll Now"),
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
              title: "About this course",
              body: widget.course.description,
            ),
            const SizedBox(height: 8),
// todo : don't forget to add instrctors list
            BlocBuilder<OrganizationBloc, OrganizationState>(
                builder: (context, state) => OrganizationCard(
                      organization: state.organization,
                      loading: state.status == OrganizationStatus.loading,
                    ))
          ],
        ),
      ),
    );
  }

  Widget _buildLessonsTab() {
    return BlocBuilder<ModuleBloc, ModuleState>(
      builder: (context, state) => state.status == ModuleStatus.loading
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: state.status == ModuleStatus.loading
                  ? 3
                  : context.read<ModuleBloc>().state.modules.length,
              itemBuilder: (context, moduleIndex) {
                final module = state.status == ModuleStatus.loading
                    ? null
                    : context.read<ModuleBloc>().state.modules[moduleIndex];

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    state.status == ModuleStatus.loading
                        ? Shimmer.fromColors(
                            baseColor: context.colors.outline,
                            highlightColor: context.colors.outlineVariant,
                            child: Container(
                              margin: EdgeInsets.symmetric(vertical: 8),
                              decoration: BoxDecoration(
                                color: Colors.grey,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              width: context.width / 3,
                              height: 10,
                            ),
                          )
                        : Text(module!.title.split(" -").first,
                            style: context.textTheme.bodyLarge
                                ?.copyWith(color: context.colors.onSurface)),
                    const SizedBox(height: 8),
                    ...List.generate(
                      module?.sections.length ?? 0,
                      (sectionIndex) {
                        final section = module!.sections[sectionIndex];
                        final isExpanded =
                            _expandedIndex == '$moduleIndex-$sectionIndex';

                        return state.status == ModuleStatus.loading
                            ? Shimmer.fromColors(
                                baseColor: context.colors.outline,
                                highlightColor: context.colors.outlineVariant,
                                child: Container(
                                  margin: EdgeInsets.symmetric(vertical: 8),
                                  decoration: BoxDecoration(
                                    color: Colors.grey,
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  width: double.infinity,
                                  height: 80,
                                ),
                              )
                            : Container(
                                margin: const EdgeInsets.only(bottom: 12),
                                decoration: BoxDecoration(
                                  color: context.colors.primaryContainer,
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: ExpansionTile(
                                  onExpansionChanged: (expanded) {
                                    setState(() => _expandedIndex = expanded
                                        ? '$moduleIndex-$sectionIndex'
                                        : null);
                                  },
                                  initiallyExpanded: isExpanded,
                                  trailing: Icon(
                                    isExpanded
                                        ? TablerIcons.plus
                                        : TablerIcons.minus,
                                  ),
                                  title: Text(section.title.split(" -").first),
                                  children: List.generate(
                                    section.materials.length,
                                    (lessonIndex) {
                                      final lesson =
                                          section.materials[lessonIndex];
                                      return ListTileItem(
                                        icon: switch (lesson.type) {
                                          MaterialType.VIDEO =>
                                            TablerIcons.video,
                                          MaterialType.QUIZ =>
                                            TablerIcons.help_octagon,
                                          MaterialType.ARTICLE =>
                                            TablerIcons.news,
                                        },
                                        label: lesson.title.split(" -").first,
                                        subLabel:
                                            lesson.type.name.toLowerCase(),
                                        onTap: () => context.push(
                                            switch (lesson.type) {
                                              MaterialType.VIDEO =>
                                                Routes.videoLesson,
                                              MaterialType.QUIZ =>
                                                Routes.quizLesson,
                                              MaterialType.ARTICLE =>
                                                Routes.reviews,
                                            },
                                            arguments: {"material": lesson}),
                                      );
/*ListTile(
                                        onTap: () {
                                          String route;

                                          if (lesson.type.name ==
                                              MaterialType.VIDEO.name) {
                                            route = Routes.videoLesson;
                                          } else if (lesson.type.name ==
                                              MaterialType.QUIZ.name) {
                                            route = Routes.quizLesson;
                                          } else {
                                            route = Routes.reviews;
                                          }

                                          context.push(route,
                                              arguments: {"material": lesson});
                                        },
                                        leading: CircleAvatar(
                                          radius: 16,
                                          backgroundColor:
                                              context.colors.primary,
                                          child: Text(
                                              '${lessonIndex + 1}'
                                                  .padLeft(2, '0'),
                                              style: context
                                                  .textTheme.labelLarge
                                                  ?.copyWith(
                                                      color: context
                                                          .colors.onPrimary)),
                                        ),
                                        title: Text(
                                          lesson.title.split(" -").first,
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        subtitle: Text(
                                            lesson.type.name.toLowerCase()),
                                        trailing: Icon(
                                          // todo : add logic for locked
                                          // lesson['locked']
                                          true
                                              ? Icons.lock_outline
                                              : Icons.play_circle_fill,
                                          color:
                                              // lesson['locked']
                                              true
                                                  ? Colors.grey
                                                  : const Color(0xFFFFBD12),
                                          size: 28,
                                        ),
                                      );*/
                                    },
                                  ),
                                ),
                              );
                      },
                    ),
                  ],
                );
              },
            ),
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
