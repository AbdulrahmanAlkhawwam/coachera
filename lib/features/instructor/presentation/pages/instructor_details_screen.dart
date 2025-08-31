import 'package:coachera/core/utils/app_context.dart';
import 'package:coachera/features/instructor/presentation/bloc/bloc/instructor_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/utils/app_image.dart';
import '../../../course/presentation/bloc/bloc/course_bloc.dart';
import '../../../course/presentation/widgets/course_horizontal_card.dart';
import '../../domain/entities/instructor.dart';

class InstructorDetailsScreen extends StatefulWidget {
  final Instructor instructor;

  const InstructorDetailsScreen({super.key, required this.instructor});

  @override
  State<InstructorDetailsScreen> createState() =>
      _InstructorDetailsScreenState();
}

class _InstructorDetailsScreenState extends State<InstructorDetailsScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    context
        .read<CourseBloc>()
        .add(GetInstructorCourses(instructorId: widget.instructor.id));
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final size = context.height * 1.85 / 5;

    return MultiBlocListener(
      listeners: [
        BlocListener<InstructorBloc, InstructorState>(
          listener: (context, state) {},
        ),
        BlocListener<CourseBloc, CourseState>(
          listener: (context, state) {
            if (state.status == CourseStatus.error) {
              context.showErrorSnackBar(massage: state.message);
            }
          },
        )
      ],
      child: Scaffold(
        body: Column(
          children: [
            Stack(
              children: [
                ClipPath(
                  clipper: _HeaderArchClipper(),
                  child: Container(
                    height: size,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Color(0xFF20C997),
                          Color(0xFF18B4AC),
                        ],
                      ),
                    ),
                    padding: const EdgeInsets.only(top: 40),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              IconButton(
                                icon: const Icon(Icons.arrow_back),
                                onPressed: () => Navigator.pop(context),
                              ),
                            ],
                          ),
                        ),
                        CircleAvatar(
                          radius: 45,
                          backgroundColor: context.colors.surface,
                          child: CircleAvatar(
                            radius: 42,
                            backgroundColor: Colors.transparent,
                            child: ClipOval(
                              child: AppImage(
                                "https://avatar.iran.liara.run/public/${widget.instructor.id}",
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          widget.instructor.name,
                          style: theme.textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.bold, color: Colors.white),
                        ),
                        Text(
                          "Senior UI/UX Designer",
                          style: theme.textTheme.bodySmall
                              ?.copyWith(color: context.colors.onPrimaryFixed),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            _StatColumn("5", "Courses"),
                            const SizedBox(width: 20),
                            _StatColumn("17", "Students"),
                            const SizedBox(width: 20),
                            _StatColumn("5", "Reviews"),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
            TabBar(
              controller: _tabController,
              tabs: const [
                Tab(text: "About"),
                Tab(text: "Courses"),
                Tab(text: "Reviews"),
              ],
            ),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  _buildAboutTab(context),
                  _buildCoursesTab(context),
                  _buildReviewsTab(context),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAboutTab(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Instructor Bio",
            style: context.textTheme.titleMedium,
          ),
          const SizedBox(height: 8),
          Text(widget.instructor.bio,
              style: context.textTheme.bodyMedium?.copyWith(
                  color: context.colors.outlineVariant.withAlpha(120))),
        ],
      ),
    );
  }

  Widget _buildCoursesTab(BuildContext context) {
    return BlocBuilder<CourseBloc, CourseState>(
      builder: (context, state) => ListView.separated(
        separatorBuilder: (context, index) => const SizedBox(height: 16),
        padding: const EdgeInsets.all(16.0),
        itemCount: state.courses.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) => CourseHorizontalCard(
          course: state.courses[index],
        ),
      ),
    );
  }

  Widget _buildReviewsTab(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16.0),
      children: const [
        _ReviewCard(
          image: 'assets/images/user1.jpg',
          name: "Ben Parker",
          rating: 5,
          date: "12 Feb 2022",
          review:
              "The explanation is very easy to understand, really cool, understandable and.",
        ),
        _ReviewCard(
          image: 'assets/images/user2.jpg',
          name: "Jen Maria",
          rating: 4.5,
          date: "1 Jan 2022",
          review: "Clear and easy to understand.",
        ),
        _ReviewCard(
          image: 'assets/images/user3.jpg',
          name: "Diaz Christian",
          rating: 3.5,
          date: "29 Dec 2021",
          review:
              "The presentation has been good, just for the explanation of the tools, I don't think I understand it as a layman.",
        ),
      ],
    );
  }
}

// Reusable Widgets
class _StatColumn extends StatelessWidget {
  final String count;
  final String label;

  const _StatColumn(this.count, this.label);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(count,
            style: context.textTheme.titleMedium?.copyWith(
              color: context.colors.onPrimaryFixed,
            )),
        const SizedBox(height: 4),
        Text(label,
            style: context.textTheme.bodyMedium?.copyWith(color: Colors.white)),
      ],
    );
  }
}

class _ReviewCard extends StatelessWidget {
  final String image;
  final String name;
  final double rating;
  final String date;
  final String review;

  const _ReviewCard({
    required this.image,
    required this.name,
    required this.rating,
    required this.date,
    required this.review,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: CircleAvatar(child: AppImage(image), radius: 24),
      title: Row(
        children: [
          Text(name, style: const TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(width: 8),
          Row(
            children: List.generate(5, (index) {
              if (rating >= index + 1) {
                return const Icon(Icons.star, color: Colors.orange, size: 16);
              } else if (rating > index) {
                return const Icon(Icons.star_half,
                    color: Colors.orange, size: 16);
              } else {
                return const Icon(Icons.star_border,
                    color: Colors.orange, size: 16);
              }
            }),
          ),
          const SizedBox(width: 6),
          Text("• $date",
              style: const TextStyle(color: Colors.grey, fontSize: 12)),
        ],
      ),
      subtitle: Padding(
        padding: const EdgeInsets.only(top: 4),
        child: Text(review),
      ),
    );
  }
}

class _HeaderArchClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(0, size.height - 40);
    path.quadraticBezierTo(
        size.width / 2, size.height, size.width, size.height - 40);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
