import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../core/utils/app_context.dart';
import '../../../../core/utils/app_image.dart';
import '../../../home/presentation/manager/bloc/favorite_bloc.dart';
import '../../domain/entities/course.dart';
import '../../domain/entities/module.dart';
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
    context.read<CourseBloc>().add(GetModules(courseId: widget.course.id));
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
                            Text(
                              widget.course.title,
                              style: context.textTheme.titleLarge
                                  ?.copyWith(color: Colors.white),
                            ),
                            Spacer(),
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
                                        baseColor: Colors.grey.shade300,
                                        highlightColor: Colors.grey.shade100,
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
                            RatingBarIndicator(
                              rating: (widget.course.rating * 2).round() / 2,
                              itemBuilder: (context, index) => Icon(
                                TablerIcons.star_filled,
                                color: context.colors.secondary,
                              ),
                              itemCount: 5,
                              itemSize: 22.0,
                              unratedColor: Colors.grey[600],
                              direction: Axis.horizontal,
                            ),
                            const SizedBox(width: 4),
                            Text(widget.course.rating.toString(),
                                style: TextStyle(color: Colors.white)),
                            const SizedBox(width: 8),
                            Text(
                                widget.course.instructors.length > 1
                                    ? "By Some Instructors"
                                    : widget.course.instructors.firstOrNull ==
                                            null
                                        ? ""
                                        : "by ${widget.course.instructors.first}",
                                style: TextStyle(color: Color(0xFFA7A7A7))),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: const [
                            Text("All Levels",
                                style: TextStyle(color: Color(0xFFA7A7A7))),
                            Text("1.2k students",
                                style: TextStyle(color: Color(0xFFA7A7A7))),
                            Text("12 Lessons",
                                style: TextStyle(color: Color(0xFFA7A7A7))),
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
      // floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,

      bottomNavigationBar: Padding(
        padding: EdgeInsets.only(
            left: 24.0,
            right: 24.0,
            top: 16,
            bottom: 16 + context.bottomPadding),
        child: Row(
          children: [
            Expanded(
              child: ElevatedButton(
                onPressed: () {},
                child: const Text("Buy Now",
                    style: TextStyle(color: Colors.black)),
              ),
            ),
            const SizedBox(width: 8.0),
            Expanded(
              child: FilledButton(
                onPressed: () {},
                child: const Text("Buy Now",
                    style: TextStyle(color: Colors.black)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailsTab() {
    return const Padding(
      padding: EdgeInsets.all(16.0),
      child: SingleChildScrollView(
        child: Column(
          children: [
            CourseDescription(
              title: "About this course",
              body:
                  "This course will guide you through the basics of mindfulness and how to apply meditation in your daily life. "
                  "You'll learn different techniques, explore the science behind mindfulness, and develop habits that support mental well-being. "
                  "By the end of this course, you will be able to integrate mindfulness into your routine and lead a more balanced life.",
            ),
            const SizedBox(
              height: 8.0,
            ),
            CourseDescription(
              title: "About this course",
              body:
                  "This course will guide you through the basics of mindfulness and how to apply meditation in your daily life. "
                  "You'll learn different techniques, explore the science behind mindfulness, and develop habits that support mental well-being. "
                  "By the end of this course, you will be able to integrate mindfulness into your routine and lead a more balanced life.",
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLessonsTab() {
    final List<Module> modules = context.read<CourseBloc>().state.modules ;

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: modules.length,
      itemBuilder: (context, moduleIndex) {
        final module = modules[moduleIndex];
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              module.title,
              style: const TextStyle(
                color: Color(0xFF00D1B7),
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 8),
            ...List.generate(module.sections.length, (sectionIndex) {
              final section = module.sections[sectionIndex];
              final isExpanded = _expandedIndex == '$moduleIndex-$sectionIndex';

              return Container(
                margin: const EdgeInsets.only(bottom: 12),
                decoration: BoxDecoration(
                  color: const Color(0xFF2D2D30),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: ExpansionTile(
                  onExpansionChanged: (expanded) {
                    setState(() => _expandedIndex =
                        expanded ? '$moduleIndex-$sectionIndex' : null);
                  },
                  initiallyExpanded: isExpanded,
                  trailing: Icon(
                    isExpanded ? Icons.remove : Icons.add,
                    color: Colors.white,
                  ),
                  title: Text(
                    section.title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  children: List.generate(
                    section.materials.length,
                    (lessonIndex) {
                      final lesson = section.materials[lessonIndex];
                      return ListTile(
                        leading: CircleAvatar(
                          radius: 16,
                          backgroundColor: const Color(0xFF00D1B7),
                          child: Text(
                            '${lessonIndex + 1}'.padLeft(2, '0'),
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        title: Text(
                          lesson.title,
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        trailing: Icon(
                          // todo : add logic for locked
                          // lesson['locked']
                          true ? Icons.lock_outline : Icons.play_circle_fill,
                          color:
                              // lesson['locked']
                              true ? Colors.grey : const Color(0xFFFFBD12),
                          size: 28,
                        ),
                      );
                    },
                  ),
                ),
              );
            }),
          ],
        );
      },
    );
  }

  Widget _buildReviewsTab() {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: 5,
      itemBuilder: (context, index) => Card(
        color: const Color(0xFF2D2D30),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        child: const ListTile(
          title: Text("Great course!", style: TextStyle(color: Colors.white)),
          subtitle: Text("Really helped me to stay focused.",
              style: TextStyle(color: Color(0xFFA7A7A7))),
        ),
      ),
    );
  }
}
