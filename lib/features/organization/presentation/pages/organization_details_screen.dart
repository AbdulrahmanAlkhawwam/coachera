import 'package:coachera/core/components/learning_path_card.dart';
import 'package:coachera/features/course/domain/entities/completionState.dart';
import 'package:coachera/features/home/presentation/widgets/organizations_list.dart';
import 'package:coachera/features/instructor/presentation/bloc/bloc/instructor_bloc.dart';
import 'package:coachera/features/learningPath/presentation/bloc/bloc/learning_path_bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart' hide MaterialType;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';
import 'package:shimmer/shimmer.dart';
import 'package:collection/collection.dart';
import '../../../../core/components/list_tile_item.dart';
import '../../../../core/components/rate.dart';
import '../../../../core/constants/routes.dart';
import '../../../../core/utils/app_context.dart';
import '../../../../core/utils/app_image.dart';
import '../../../course/presentation/bloc/bloc/course_bloc.dart';
import '../../../course/presentation/widgets/course_card.dart';
import '../../../course/presentation/widgets/course_description.dart';
import '../../../home/domain/entities/card_type.dart';
import '../../../home/presentation/manager/favorite_bloc/favorite_bloc.dart';
import '../../../home/presentation/widgets/instructor_list.dart';
import '../../../instructor/presentation/widgets/instructor_card.dart';
import '../../../material/domain/entities/material_type.dart';
import '../../../module/presentation/bloc/bloc/module_bloc.dart';
import '../../../material/data/model/material_model.dart';
import '../../../organization/presentation/bloc/bloc/organization_bloc.dart';
import '../../../organization/presentation/widgets/organization_card.dart';
import '../../../review/presentation/bloc/bloc/review_bloc.dart';
import '../../../review/presentation/widgets/review_card.dart';
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
  String? _expandedIndex;

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
    // context
    // .read<InstructorBloc>()
    // .add(GetCourseInstructors(courseId: widget.organization.id));
    // context
    //     .read<OrganizationBloc>()
    //     .add(GetOrganization(orgId: widget.organization.orgId));
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
            // AppImage(
            //   widget.organization.image,
            //   fit: BoxFit.cover,
            //   width: double.infinity,
            // ),
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
                            // BlocConsumer<FavoriteBloc, FavoriteState>(
                            //   listener: (context, state) {
                            //     if (state.status == FavoriteStatus.error) {
                            //       context.showErrorSnackBar(
                            //           massage: state.message);
                            //     }
                            //   },
                            //   builder: (context, state) => IconButton(
                            //     onPressed: () => state.isFavorite ?? false
                            //         ? context.read<FavoriteBloc>().add(
                            //             DeleteFavorite(
                            //                 courseId: widget.organization.id))
                            //         : context.read<FavoriteBloc>().add(
                            //             AddFavorite(
                            //                 courseId: widget.organization.id)),
                            //     icon: state.status == FavoriteStatus.loading
                            //         ? Shimmer.fromColors(
                            //             baseColor: context.colors.outline,
                            //             highlightColor:
                            //                 context.colors.outlineVariant,
                            //             child: Icon(TablerIcons.heart_filled),
                            //           )
                            //         : Icon(
                            //             state.isFavorite ?? true
                            //                 ? TablerIcons.heart_filled
                            //                 : TablerIcons.heart,
                            //             color: state.isFavorite ?? false
                            //                 ? context.colors.error
                            //                 : null,
                            //           ),
                            //   ),
                            // ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            // Rate(
                            //     rate:
                            //         widget.organization.rating * 2.round() / 2),
                            // const SizedBox(width: 4),
                            // Text(widget.organization.rating.toString()),
                            // const SizedBox(width: 8),
                            // Text(
                            //     widget.organization.instructors.length > 1
                            //         ? "By Some Instructors"
                            //         : widget.organization.instructors
                            //                     .firstOrNull ==
                            //                 null
                            //             ? ''
                            //             : "by ${context.read<InstructorBloc>().state.instructors.firstOrNull?.name}",
                            //     style: context.textTheme.bodyMedium?.copyWith(
                            //       color: context.colors.primary,
                            //       fontWeight: FontWeight.w600,
                            //     )),
                          ],
                        ),
                        const SizedBox(height: 12),
                        // Row(
                        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        // children: [
                        //   Text("${widget.organization.price} \$",
                        //       style: context.textTheme.titleMedium?.copyWith(
                        //         color: context.colors.primary,
                        //       )),
                        //   Text(widget.organization.durationHours,
                        //       style: context.textTheme.bodyMedium?.copyWith(
                        //         color: context.colors.outlineVariant
                        //             .withAlpha(160),
                        //       )),
                        // ],
                        // ),
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
                        // _buildLearningPathsTab(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      // bottomNavigationBar: Padding(
      //   padding: EdgeInsets.only(
      //       left: 24.0,
      //       right: 24.0,
      //       top: 16,
      //       bottom: 16 + context.bottomPadding),
      // child: FilledButton(
      //   onPressed: () => context
      //       .read<CourseBloc>()
      //       .add(EnrollCourse(courseId: widget.organization.id)),
      //   child: const Text("Enroll Now"),
      // ),
      // ),
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
            // BlocBuilder<OrganizationBloc, OrganizationState>(
            //   builder: (context, state) => Column(
            //     crossAxisAlignment: CrossAxisAlignment.start,
            //     children: [
            //       Padding(
            //         padding: const EdgeInsets.symmetric(vertical: 16),
            //         child: Text("Course Organizations",
            //             style: context.textTheme.titleSmall),
            //       ),
            //       OrganizationCard(
            //         cardType: CardType.horizontal,
            //         organization: state.organization,
            //         loading: state.status == OrganizationStatus.loading,
            //       ),
            //     ],
            //   ),
            // ),
            // BlocBuilder<InstructorBloc, InstructorState>(
            //   builder: (context, state) => state.instructors.length == 1
            //       ? Column(
            //           crossAxisAlignment: CrossAxisAlignment.start,
            //           children: [
            //             Padding(
            //               padding: const EdgeInsets.symmetric(vertical: 16),
            //               child: Text("Course Instructors",
            //                   style: context.textTheme.titleSmall),
            //             ),
            //             InstructorCard(
            //               cardType: CardType.horizontal,
            //               instructor: state.instructors.first,
            //               loading: state.status == InstructorStatus.loading,
            //             ),
            //           ],
            //         )
            //       : InstructorList(
            //           showMore: false,
            //           instructors: state.instructors,
            //           loading: state.status == InstructorStatus.loading,
            //         ),
            // ),
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

  // Widget _buildLessonsTab() {
  //   return BlocBuilder<ModuleBloc, ModuleState>(
  //     builder: (context, state) => state.status == ModuleStatus.loading
  //         ? Center(child: CircularProgressIndicator())
  //         : ListView.builder(
  //             padding: const EdgeInsets.all(16),
  //             itemCount: context.read<ModuleBloc>().state.modules.length,
  //             itemBuilder: (context, moduleIndex) {
  //               final module =
  //                   context.read<ModuleBloc>().state.modules[moduleIndex];
  //
  //               return Column(
  //                 crossAxisAlignment: CrossAxisAlignment.start,
  //                 children: [
  //                   Text(module.title.split(" -").first,
  //                       style: context.textTheme.bodyLarge
  //                           ?.copyWith(color: context.colors.onSurface)),
  //                   const SizedBox(height: 8),
  //                   ...List.generate(
  //                     module.sections.length,
  //                     (sectionIndex) {
  //                       final section = module.sections[sectionIndex];
  //                       final isExpanded =
  //                           _expandedIndex == '$moduleIndex-$sectionIndex';
  //
  //                       return Container(
  //                         margin: const EdgeInsets.only(bottom: 12),
  //                         decoration: BoxDecoration(
  //                           color: context.colors.primaryContainer,
  //                           borderRadius: BorderRadius.circular(12),
  //                         ),
  //                         child: ExpansionTile(
  //                           onExpansionChanged: (expanded) {
  //                             setState(() => _expandedIndex = expanded
  //                                 ? '$moduleIndex-$sectionIndex'
  //                                 : null);
  //                           },
  //                           initiallyExpanded: isExpanded,
  //                           trailing: Icon(
  //                             isExpanded ? TablerIcons.minus : TablerIcons.plus,
  //                           ),
  //                           title: Text(section.title.split(" -").first),
  //                           children: List.generate(
  //                             section.materials.length,
  //                             (lessonIndex) {
  //                               final lesson = section.materials[lessonIndex];
  //
  //                               final courseState =
  //                                   context.read<CourseBloc>().state;
  //
  //                               final courseProgress = courseState.progress
  //                                   .where((p) =>
  //                                       p.organization.id ==
  //                                       widget.organization.id)
  //                                   .cast<Progress?>()
  //                                   .firstOrNull;
  //
  //                               هل هذا الدرس مكتمل؟
  //                               final isCompleted =
  // courseProgress?.materialCompletions.any(
  //       (m) =>
  //           m.materialId == lesson.id &&
  //           m.completed,
  //     ) ??
  //     false;
//
// الطالب يقدر يفتح أي درس
//                                 final accessible = true;
//
// أيقونة trailing
//                                 IconData? trailingIcon;
//                                 Color? trailingColor;
//
//                                 if (isCompleted) {
//                                   trailingIcon = TablerIcons.check;
//                                   trailingColor = context.colors.primary;
//                                 } else {
//                                   trailingIcon = null; // default
//                                   trailingColor = null;
//                                 }
//
  // هل المستخدم مسجل بالكورس؟
  // final isEnrolled = courseState.progress.any(
  //     (p) => p.course.id == widget.course.id);
  //
  // // ProgressModel الخاص بالكورس الحالي أو null إذا غير مسجل

  // // الدروس كلها
  // final allLessons = widget.course.modules
  //     .expand((m) => m.sections)
  //     .expand((s) => s.materials)
  //     .toList();
  //
  // // آخر درس مكتمل
  // final lastCompleted = courseProgress
  //     ?.materialCompletions
  //     .where((m) => m.completed)
  //     .lastOrNull;
  //
  // final lastIndex = lastCompleted != null
  //     ? allLessons.indexWhere(
  //         (l) => l.id == lastCompleted.materialId)
  //     : -1;
  //
  // final currentIndex = allLessons
  //     .indexWhere((l) => l.id == lesson.id);
  //
  // // هل هذا الدرس مكتمل؟
  // final isCompleted =
  //     courseProgress?.materialCompletions.any(
  //           (m) =>
  //               m.materialId == lesson.id &&
  //               m.completed,
  //         ) ??
  //         false;
  //
  // // هل هذا الدرس هو التالي بعد آخر مكتمل؟
  // final isNextAfterCompleted =
  //     currentIndex == lastIndex + 1;
  //
  // // هل هذا هو أول درس بالكورس؟
  // final isFirstLesson = moduleIndex == 0 &&
  //     sectionIndex == 0 &&
  //     lessonIndex == 0;
  //
  // // المنطق النهائي للـ trailing والـ accessible
  // bool accessible = false;
  // IconData? trailingIcon;
  // Color? trailingColor;
  //
  // if (!isEnrolled) {
  //   // غير مسجل → مقفول
  //   trailingIcon = TablerIcons.lock;
  // } else if (isCompleted) {
  //   // مكتمل → صح
  //   accessible = true;
  //   trailingIcon = TablerIcons.check;
  //   trailingColor = context.colors.primary;
  // } else if (isNextAfterCompleted ||
  //     isFirstLesson) {
  //   // التالي بعد مكتمل أو أول درس → مفتوح
  //   accessible = true;
  //   trailingIcon = null;
  // } else {
  //   // غير مكتمل وما قبله مو مكتمل → مقفول
  //   trailingIcon = TablerIcons.lock;
  // }

  // return ListTileItem(
  //   icon: switch (lesson.type) {
  //     MaterialType.VIDEO => TablerIcons.video,
  //     MaterialType.QUIZ =>
  //       TablerIcons.help_octagon,
  //     MaterialType.ARTICLE => TablerIcons.news,
  //   },
  //   label: lesson.title.split(" -").first,
  //   subLabel: lesson.type.name.toLowerCase(),
  //   trailing: trailingIcon,
  //   trailingColor: trailingColor,
  //   onTap: accessible
  //       ? () {
  //           enrollment لهذا الدرس
  // final enrollment = widget.enrollments!
  //     .where(
  //       (e) =>
  //           e.materialId == lesson.id,
  //       orElse: () => MaterialCompletion(
  //   materialId: lesson.id,
  //   completed: false,
  //   enrollmentId: 0,
  // ),
  // )
  // .first;

  // فتح الدرس المناسب
  // context.push(
  //   switch (lesson.type) {
  //     MaterialType.VIDEO =>
  //       Routes.videoLesson,
  //     MaterialType.QUIZ =>
  //       Routes.quizLesson,
  //     MaterialType.ARTICLE =>
  //       Routes.articleLesson,
  //   },
  //   arguments: {
  //     "material": lesson,
  //     "enrollmentId":
  //         enrollment.enrollmentId,
  //     'complete': isCompleted,
  //   },
  // );
  // }
  // : null,
  // );
  // },
  // ),
  // ),
  // );
  // },
  // ),
  // ],
  // );
  // },
  // ),
  // );
  // }

  // Widget _buildLearningPathsTab() {
  //   return BlocBuilder<LearningPathBloc, LearningPathBloc>(
  //     builder: (context, state) => state.status == CourseStatus.loading
  //         ? Center(child: CircularProgressIndicator())
  //         : ListView.builder(
  //       padding: const EdgeInsets.all(16),
          // itemCount: state.courses.length,
          // itemBuilder: (context, index) => LearningPathAds(
          //   course: state.courses[index],
          //   loading: state.status == CourseStatus.loading,
          //   type: CardType.horizontal,
          // )),
    // );
  // }
}
