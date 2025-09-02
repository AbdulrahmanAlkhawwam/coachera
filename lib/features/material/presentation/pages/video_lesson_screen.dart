import 'package:better_player_plus/better_player_plus.dart';
import 'package:flutter/material.dart' hide Material;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';

import '../../../../core/components/rate.dart';
import '../../../../core/utils/app_context.dart';
import '../../../course/presentation/widgets/course_description.dart';
import '../../domain/entities/material.dart';
import '../bloc/bloc/material_bloc.dart';

class VideoLessonScreen extends StatefulWidget {
  const VideoLessonScreen({super.key, required this.lesson});

  final Material lesson;

  @override
  State<VideoLessonScreen> createState() => _VideoLessonScreenState();
}

class _VideoLessonScreenState extends State<VideoLessonScreen>
    with SingleTickerProviderStateMixin {
  late BetterPlayerController _betterPlayerController;
  late TabController _tabController;
  int? _expandedIndex;

  @override
  void initState() {
    print(widget.lesson.toString());
    super.initState();
    context.read<MaterialBloc>().add(GetMaterial(materialId: widget.lesson.id));
    BetterPlayerDataSource dataSource = BetterPlayerDataSource(
      BetterPlayerDataSourceType.network,
      "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4",
    );
    _betterPlayerController = BetterPlayerController(
      const BetterPlayerConfiguration(
        autoPlay: false,
        aspectRatio: 16 / 9,
      ),
      betterPlayerDataSource: dataSource,
    );

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
    print(widget.lesson.title);
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
                              widget.lesson.title,
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
                        // _buildLessonsTab(),
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
      // bottomNavigationBar: Padding(
      //   padding: EdgeInsets.only(
      //       left: 24.0,
      //       right: 24.0,
      //       top: 16,
      //       bottom: 16 + context.bottomPadding),
      //   child: Row(
      //     children: [
      //       Expanded(
      //         child: ElevatedButton(
      //           // style: ElevatedButton.styleFrom(
      //           //   backgroundColor: const Color(0xFFFFBD12),
      //           //   shape: RoundedRectangleBorder(
      //           //     borderRadius: BorderRadius.circular(12),
      //           //   ),
      //           // ),
      //           onPressed: () {},
      //           child: const Text("Buy Now",
      //               style: TextStyle(color: Colors.black)),
      //         ),
      //       ),
      //       const SizedBox(width: 8.0),
      //       Expanded(
      //         child: FilledButton(
      //           // style: ElevatedButton.styleFrom(
      //           //   backgroundColor: const Color(0xFFFFBD12),
      //           //   shape: RoundedRectangleBorder(
      //           //     borderRadius: BorderRadius.circular(12),
      //           //   ),
      //           // ),
      //           onPressed: () {},
      //           child: const Text("Buy Now",
      //               style: TextStyle(color: Colors.black)),
      //         ),
      //       ),
      //     ],
      //   ),
      // ),
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

  // Widget _buildLessonsTab() {
  //   final List<Map<String, dynamic>> sections =
  //       List.generate(3, (sectionIndex) {
  //     return {
  //       "title": "Section ${sectionIndex + 1}",
  //       "lessons": List.generate(4, (lessonIndex) {
  //         return {
  //           "title": "Lesson ${lessonIndex + 1}",
  //           "duration": "${10 + lessonIndex} min",
  //         };
  //       }),
  //     };
  //   });

  // return ListView.builder(
  //   padding: EdgeInsets.all(16),
  //   itemCount: widget.course.modules.length,
  //   itemCount: sections.length,
  // itemBuilder: (context, moduleIndex) {
  //   final modules = widget.course.modules[moduleIndex];
  //   final section = sections[sectionIndex];
  // final isExpanded = _expandedIndex == moduleIndex;
  //
  // return Container(
  //   margin: const EdgeInsets.only(bottom: 0),
  //   decoration: BoxDecoration(
  //     color: const Color(0xFF2D2D30),
  // borderRadius: BorderRadius.circular(8),
  // ),
  // child: Theme(
  //   data: Theme.of(context).copyWith(
  //     dividerColor: Colors.transparent,
  //     unselectedWidgetColor: Colors.white,
  //     colorScheme: ColorScheme.dark(),
  //   ),
  //   child: ExpansionTile(
  //     onExpansionChanged: (expanded) {
  //       setState(() {
  //         _expandedIndex = expanded ? moduleIndex : null;
  //       });
  //     },
  //     initiallyExpanded: isExpanded,
  //     trailing: Icon(
  //       isExpanded ? TablerIcons.plus : TablerIcons.minus,
  //       color: Colors.white,
  //     ),
  //     title: Text(
  //       modules.title,
  //       style: const TextStyle(
  //         color: Colors.grey,
  //         fontWeight: FontWeight.bold,
  //       ),
  //     ),
  //     children: List.generate(modules.sections.length, (sectionIndex) {
  //       final sections = modules.sections[sectionIndex];
  //       return ListTile(
  //         contentPadding: const EdgeInsets.symmetric(horizontal: 16),
  //         title: Text(
  //           sections.title,
  //           style: const TextStyle(color: Colors.white),
  //         ),
  //         subtitle: Text(
  //           sections.title,
  //           style: const TextStyle(color: Color(0xFFA7A7A7)),
  //         ),
  //         trailing: const Icon(
  //           Icons.play_circle_fill,
  //           color: Color(0xFFFFBD12),
  //         ),
  //         onTap: () {
  //           Handle material tap
  // },
  // );
  // }),
  // ),
  // ),
  // );
  // },
  // );
  // }

  Widget _buildReviewsTab() {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: 5,
      itemBuilder: (context, index) => Card(
        // color: const Color(0xFF2D2D30),
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
