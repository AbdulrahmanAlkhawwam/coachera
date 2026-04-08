import 'package:better_player_plus/better_player_plus.dart';
import 'package:coachera/features/material/domain/param/complete_lesson.dart';
import 'package:flutter/material.dart' hide Material;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';

import '../../../../core/utils/app_context.dart';
import '../../../course/presentation/widgets/course_description.dart';
import '../../domain/entities/material.dart';
import '../bloc/bloc/material_bloc.dart';

class VideoLessonScreen extends StatefulWidget {
  final Material material;
  final bool isComplete;
  final int enrollmentId;

  const VideoLessonScreen({
    super.key,
    required this.material,
    required this.isComplete,
    required this.enrollmentId,
  });

  @override
  State<VideoLessonScreen> createState() => _VideoLessonScreenState();
}

class _VideoLessonScreenState extends State<VideoLessonScreen>
    with SingleTickerProviderStateMixin {
  late BetterPlayerController _betterPlayerController;
  late TabController _tabController;
  bool _isVideoEnded = false;

  @override
  void initState() {
    super.initState();
    context
        .read<MaterialBloc>()
        .add(GetMaterial(materialId: widget.material.id));
    BetterPlayerDataSource dataSource = BetterPlayerDataSource(
      BetterPlayerDataSourceType.network,
      "https${widget.material.videoUrl?.substring(4)}" 
    );

    _betterPlayerController = BetterPlayerController(
      const BetterPlayerConfiguration(
        autoPlay: false,
        aspectRatio: 16 / 9,
      ),
      betterPlayerDataSource: dataSource,
    );

    _betterPlayerController.addEventsListener((event) {
      if (event.betterPlayerEventType == BetterPlayerEventType.finished) {
        setState(() {
          _isVideoEnded = true;
        });
      }
    });

    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _betterPlayerController.dispose();
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
            BetterPlayer(controller: _betterPlayerController),
            Expanded(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16.0, vertical: 12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              widget.material.title,
                              style: context.textTheme.titleLarge
                                  ?.copyWith(color: Colors.white),
                            ),
                            Spacer(),
                            IconButton(
                                onPressed: () {}, icon: Icon(TablerIcons.heart))
                          ],
                        ),
                        const SizedBox(height: 8),
                        const Text("4.8",
                            style: TextStyle(color: Colors.white)),
                        const SizedBox(width: 8),
                        const Text("by Emma Johnson",
                            style: TextStyle(color: Color(0xFFA7A7A7))),
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
      floatingActionButton: !widget.isComplete && _isVideoEnded
          ? FilledButton(
              onPressed: () => context.read<MaterialBloc>().add(CompleteLesson(
                      param: CompleteLessonParam(
                    enrollmentId: widget.enrollmentId,
                    materialId: widget.material.id,
                  ))),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: const [
                  Text("Complete Lesson"),
                  SizedBox(width: 8),
                  Icon(TablerIcons.arrow_right)
                ],
              ),
            )
          : const SizedBox(),
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
            SizedBox(
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

  Widget _buildReviewsTab() {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: 5,
      itemBuilder: (context, index) => Card(
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
