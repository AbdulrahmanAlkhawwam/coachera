import 'package:coachera/core/utils/app_image.dart';
import 'package:flutter/material.dart';

import '../../../../core/utils/app_context.dart';

class InstructorDetailsScreen extends StatefulWidget {
  const InstructorDetailsScreen({super.key});

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
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.canPop(context) ? context.pop() : null,
        ),
        title: Text("Profile Mentor"),
        actions: [
          IconButton(
            icon: const Icon(Icons.more_horiz),
            onPressed: () {},
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            Stack(
              alignment: Alignment.topCenter,
              children: [
                Container(
                  margin: const EdgeInsets.only(
                    left: 24,
                    right: 24,
                    top: 40,
                  ),
                  padding: EdgeInsets.only(top: 48, bottom: 24),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        context.isDark ? Color(0xFF051715) : Color(0xFFDEF5F3),
                        context.isDark ? Color(0xFF071F1D) : Color(0xFFF5FBF9),
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(32),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "Azamat Baimatov",
                        style: context.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: context.colors.onSurface,
                        ),
                      ),
                      Text(
                        "Senior UI/UX Designer",
                        style: context.textTheme.bodySmall
                            ?.copyWith(color: Colors.grey),
                      ),
                      const SizedBox(height: 12),
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
                const CircleAvatar(
                  radius: 40,
                  child: AppImage(
                    height: 40,
                    'assets/images/instructor.jpg',
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),

            TabBar(
              controller: _tabController,
              tabs: const [
                Tab(text: "About"),
                Tab(text: "Courses"),
                Tab(text: "Reviews"),
              ],
            ),

            // Tab Content
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
            "Hi My name is Azamat Baimatov, I work as a Senior UI/UX Designer in one of the biggest E-commerce in Indonesia. I have more than 10 years of experience UI/UX Design in Startup & Corporate.",
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          const SizedBox(height: 8),
          const Text(
              "• First we’ll describe the brief & how to work with a UX persona."),
          const Text("• Then you’ll learn how to create simple wireframes."),
          const Text(
              "• How to implement colours & images properly in your designs."),
          const Text(
              "• Do’s & don’ts around choosing fonts for web & mobile apps."),
          const Text(
              "• How to create your own icons, buttons & UI components."),
          const SizedBox(height: 16),
          Row(
            children: const [
              Icon(Icons.language, color: Colors.grey),
              SizedBox(width: 6),
              Text("Azamat.com"),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCoursesTab(BuildContext context) {
    // sample data; replace with your real list from Bloc/Repo
    final courses = [
      {
        'image': 'assets/images/course1.jpg',
        'title': 'Basic UI/UX Designer',
        'instructor': 'Azamat Baimatov',
        'price': 145.0,
        'oldPrice': 160.0,
        'rating': 4.8,
        'reviews': 534,
        'isFavorite': true,
      },
      {
        'image': 'assets/images/course2.jpg',
        'title': 'User Experience Design Essentials',
        'instructor': 'Horann Tajman',
        'price': 185.0,
        'oldPrice': 198.0,
        'rating': 4.8,
        'reviews': 418,
        'isFavorite': true,
      },
      {
        'image': 'assets/images/course3.jpg',
        'title': 'Illustrator 2022 MasterClass',
        'instructor': 'Cherrie Maria',
        'price': 135.0,
        'oldPrice': 160.0,
        'rating': 4.8,
        'reviews': 411,
        'isFavorite': false,
      },
    ];

    return ListView.builder(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 24),
      itemCount: courses.length,
      // Important: shrinkWrap:true makes this ListView safe even when placed inside
      // another scrollable (or an unbounded parent). physics allows normal vertical scroll.
      shrinkWrap: true,
      physics: const AlwaysScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        final c = courses[index];
        return Padding(
          padding: const EdgeInsets.only(bottom: 12.0),
          child: _CourseCard(
            image: c['image'] as String,
            title: c['title'] as String,
            instructor: c['instructor'] as String,
            price: c['price'] as double,
            oldPrice: c['oldPrice'] as double,
            rating: c['rating'] as double,
            reviews: c['reviews'] as int,
            isFavorite: c['isFavorite'] as bool,
            onTap: () {
              // navigate to course details (adapt to your router)
              // Navigator.pushNamed(context, '/courseDetails', arguments: ...);
            },
          ),
        );
      },
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
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              color: context.colors.primary,
            )),
        const SizedBox(height: 4),
        Text(label, style: const TextStyle(color: Colors.grey)),
      ],
    );
  }
}

class _CourseCard extends StatelessWidget {
  final String image; // can be asset path or network url
  final String title;
  final String instructor;
  final double price;
  final double oldPrice;
  final double rating; // 0.0 - 5.0
  final int reviews;
  final bool isFavorite;
  final VoidCallback? onTap;
  final VoidCallback? onFavoriteTap;

  const _CourseCard({
    required this.image,
    required this.title,
    required this.instructor,
    required this.price,
    required this.oldPrice,
    required this.rating,
    required this.reviews,
    required this.isFavorite,
    this.onTap,
    this.onFavoriteTap,
    Key? key,
  }) : super(key: key);

  static const double _imageW = 92;
  static const double _imageH = 72;
  static const double _cardRadius = 14;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Material(
      color: Theme.of(context).cardColor,
      borderRadius: BorderRadius.circular(_cardRadius),
      elevation: 0,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(_cardRadius),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Image (fixed size)
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: _buildImage(),
              ),

              const SizedBox(width: 12),

              // Text area (takes remaining width)
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  // important to avoid expanding vertically
                  children: [
                    // Title
                    Text(
                      title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: textTheme.bodyLarge
                              ?.copyWith(fontWeight: FontWeight.w700) ??
                          const TextStyle(
                              fontWeight: FontWeight.w700, fontSize: 16),
                    ),

                    const SizedBox(height: 6),

                    // Instructor
                    Text(
                      instructor,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: textTheme.labelLarge
                              ?.copyWith(color: Colors.grey[600]) ??
                          const TextStyle(color: Colors.grey, fontSize: 13),
                    ),

                    const SizedBox(height: 8),

                    // Price row
                    Row(
                      children: [
                        Text(
                          '\$${price.toStringAsFixed(0)}',
                          style: textTheme.labelLarge?.copyWith(
                                color: Colors.teal,
                                fontWeight: FontWeight.w700,
                              ) ??
                              const TextStyle(
                                  color: Colors.teal,
                                  fontWeight: FontWeight.w700),
                        ),
                        if (oldPrice > 0) ...[
                          const SizedBox(width: 8),
                          Text(
                            '\$${oldPrice.toStringAsFixed(0)}',
                            style: textTheme.labelSmall?.copyWith(
                                  decoration: TextDecoration.lineThrough,
                                  color: Colors.grey,
                                ) ??
                                const TextStyle(
                                    decoration: TextDecoration.lineThrough,
                                    color: Colors.grey),
                          ),
                        ]
                      ],
                    ),

                    const SizedBox(height: 8),

                    // Rating row
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          rating.toStringAsFixed(1),
                          style: textTheme.labelSmall
                                  ?.copyWith(fontWeight: FontWeight.w700) ??
                              const TextStyle(
                                  fontWeight: FontWeight.w700, fontSize: 12),
                        ),
                        const SizedBox(width: 6),
                        // stars
                        Row(children: _buildStars()),
                        const SizedBox(width: 8),
                        Text(
                          '($reviews)',
                          style: textTheme.labelSmall
                                  ?.copyWith(color: Colors.grey) ??
                              const TextStyle(color: Colors.grey, fontSize: 12),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(width: 8),

              // Favorite button (compact)
              _favoriteButton(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildImage() {
    final placeholder = Container(
      width: _imageW,
      height: _imageH,
      color: Colors.grey[300],
      alignment: Alignment.center,
      child: const Icon(Icons.image_outlined, size: 28, color: Colors.white70),
    );

    if (image.startsWith('http') || image.startsWith('https')) {
      return SizedBox(
        width: _imageW,
        height: _imageH,
        child: Image.network(
          image,
          fit: BoxFit.cover,
          width: _imageW,
          height: _imageH,
          errorBuilder: (_, __, ___) => placeholder,
          loadingBuilder: (context, child, progress) {
            if (progress == null) return child;
            return placeholder;
          },
        ),
      );
    } else {
      return SizedBox(
        width: _imageW,
        height: _imageH,
        child: Image.asset(
          image,
          fit: BoxFit.cover,
          errorBuilder: (_, __, ___) => placeholder,
        ),
      );
    }
  }

  List<Widget> _buildStars() {
    final stars = <Widget>[];
    for (var i = 1; i <= 5; i++) {
      if (rating >= i) {
        stars.add(const Icon(Icons.star, size: 14, color: Color(0xFFFFB020)));
      } else if (rating > i - 1) {
        stars.add(
            const Icon(Icons.star_half, size: 14, color: Color(0xFFFFB020)));
      } else {
        stars.add(
            const Icon(Icons.star_border, size: 14, color: Color(0xFFFFB020)));
      }
      if (i != 5) stars.add(const SizedBox(width: 2));
    }
    return stars;
  }

  Widget _favoriteButton(BuildContext context) {
    return Container(
      width: 36,
      height: 36,
      decoration: BoxDecoration(
        color: Theme.of(context).brightness == Brightness.light
            ? Colors.teal.withOpacity(0.08)
            : Colors.white12,
        shape: BoxShape.circle,
      ),
      child: IconButton(
        onPressed: onFavoriteTap ?? () {},
        padding: EdgeInsets.zero,
        // make the icon a bit smaller so it fits the 36x36 circle
        iconSize: 18,
        constraints: const BoxConstraints(minWidth: 36, minHeight: 36),
        icon: Icon(
          isFavorite ? Icons.favorite : Icons.favorite_border,
          color: isFavorite ? Colors.redAccent : Colors.teal,
          size: 18,
        ),
      ),
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
      leading: CircleAvatar(
          child: AppImage(
            height: 24,
            image,
          ),
          radius: 24),
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

// Custom Clipper for Arch Header
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

// import 'package:flutter/material.dart';
//
// class InstructorDetailsScreen extends StatelessWidget {
//   const InstructorDetailsScreen({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: SafeArea(
//         child: Column(
//           children: [
//             // Back & Title
//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
//               child: Row(
//                 children: [
//                   Icon(Icons.arrow_back, color: Colors.black),
//                   const SizedBox(width: 8),
//                   const Text(
//                     "Instructor/",
//                     style: TextStyle(
//                       fontSize: 16,
//                       color: Colors.black54,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//
//             // Profile Header with Arch Background
//             Stack(
//               alignment: Alignment.center,
//               children: [
//                 Container(
//                   margin: const EdgeInsets.symmetric(horizontal: 24),
//                   padding: const EdgeInsets.symmetric(vertical: 40),
//                   decoration: BoxDecoration(
//                     color: const Color(0xFFF0FCFA),
//                     borderRadius: BorderRadius.circular(32),
//                   ),
//                   child: Column(
//                     children: [
//                       const SizedBox(height: 60), // leave space for image
//                       const Text(
//                         "Azamat Baimatov",
//                         style: TextStyle(
//                           fontSize: 20,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                       const SizedBox(height: 12),
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                         children: const [
//                           _StatWidget(count: "2", label: "Courses"),
//                           _StatWidget(count: "16", label: "Students"),
//                           _StatWidget(count: "5", label: "Reviews"),
//                         ],
//                       ),
//                     ],
//                   ),
//                 ),
//
//                 // Profile Image
//                 Positioned(
//                   top: 0,
//                   child: CircleAvatar(
//                     radius: 50,
//                     backgroundImage: AssetImage('assets/images/instructor.png'),
//                   ),
//                 ),
//               ],
//             ),
//
//             const SizedBox(height: 24),
//
//             // Courses Section
//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 24),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   const Text(
//                     "Courses",
//                     style: TextStyle(
//                       fontSize: 18,
//                       fontWeight: FontWeight.w600,
//                     ),
//                   ),
//                   const SizedBox(height: 16),
//                   Container(
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(16),
//                       color: const Color(0xFFF8F8F8),
//                     ),
//                     padding: const EdgeInsets.symmetric(
//                         horizontal: 16, vertical: 20),
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: const [
//                         Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Text(
//                               "Advanced UI Design",
//                               style: TextStyle(
//                                 fontSize: 16,
//                                 fontWeight: FontWeight.bold,
//                               ),
//                             ),
//                             SizedBox(height: 4),
//                             Text(
//                               "Passionate about design people use.",
//                               style: TextStyle(
//                                 fontSize: 14,
//                                 color: Colors.black54,
//                               ),
//                             ),
//                           ],
//                         ),
//                         Icon(Icons.arrow_forward_ios, size: 16),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
//
// class _StatWidget extends StatelessWidget {
//   final String count;
//   final String label;
//
//   const _StatWidget({required this.count, required this.label});
//
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         Text(
//           count,
//           style: const TextStyle(
//             fontSize: 18,
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//         const SizedBox(height: 4),
//         Text(
//           label,
//           style: const TextStyle(
//             fontSize: 14,
//             color: Colors.black54,
//           ),
//         ),
//       ],
//     );
//   }
// }
