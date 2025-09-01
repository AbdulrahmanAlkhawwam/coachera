import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import '../../domain/entities/progress.dart';

enum ProgressCardState { loading, ongoing, completed }

class ProgressCard extends StatelessWidget {
  final Progress progressData;
  final VoidCallback onContinue;

  const ProgressCard({
    super.key,
    required this.progressData,
    required this.onContinue,
  });

  @override
  Widget build(BuildContext context) {
    // total modules in this course
    final totalModules = progressData.course.modules.length;

    // modules completed (based on materialCompletions mapping to moduleIds)
    final completedModules = progressData.course.modules
        .where((module) => progressData.materialCompletions
            .any((m) => m.id == module.id && m.completed))
        .length;

    // calculate module-based percentage
    final modulePercent =
        totalModules == 0 ? 0.0 : completedModules / totalModules;

    // decide card state
    final cardState = (completedModules == totalModules && totalModules > 0)
        ? ProgressCardState.completed
        : ProgressCardState.ongoing;

    switch (cardState) {
      case ProgressCardState.loading:
        return _buildLoadingState();
      case ProgressCardState.completed:
        return _buildCompletedState(completedModules, totalModules);
      case ProgressCardState.ongoing:
        return _buildOngoingState(
            completedModules, totalModules, modulePercent);
    }
  }

  Widget _buildLoadingState() {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      clipBehavior: Clip.antiAlias,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF20C997), Color(0xFF18B4AC)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(height: 14, width: 60, color: Colors.white24),
                  const SizedBox(height: 8),
                  Container(height: 20, width: 140, color: Colors.white30),
                  const SizedBox(height: 16),
                  Container(height: 36, width: 100, color: Colors.white24),
                ],
              ),
            ),
            const CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOngoingState(
      int completedModules, int totalModules, double modulePercent) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      clipBehavior: Clip.antiAlias,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF4FD1C5), Color(0xFF81E6D9)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Row(
          children: [
            // Left section
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        "Ongoing",
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.9),
                          fontSize: 14,
                        ),
                      ),
                      const SizedBox(width: 6),
                      Text(
                        "$completedModules/$totalModules modules",
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.7),
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Text(
                    progressData.course.title,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 10),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue[800],
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    onPressed: onContinue,
                    child: const Text("Continue"),
                  ),
                ],
              ),
            ),
            CircularPercentIndicator(
              radius: 40,
              lineWidth: 10,
              percent: modulePercent,
              circularStrokeCap: CircularStrokeCap.round,
              progressColor: Colors.tealAccent,
              backgroundColor: Colors.white24,
              center: Text(
                "${(modulePercent * 100).round()}%",
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCompletedState(int completedModules, int totalModules) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      clipBehavior: Clip.antiAlias,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF38A169), Color(0xFF48BB78)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: const [
                      Icon(Icons.check_circle, color: Colors.white),
                      SizedBox(width: 6),
                      Text(
                        "Completed",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Text(
                    progressData.course.title,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 10),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: Colors.white24,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Text(
                      "View Certificate",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
            CircularPercentIndicator(
              radius: 40,
              lineWidth: 10,
              percent: 1.0,
              circularStrokeCap: CircularStrokeCap.round,
              progressColor: Colors.white,
              backgroundColor: Colors.white24,
              center: const Icon(Icons.check, color: Colors.white, size: 28),
            ),
          ],
        ),
      ),
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:percent_indicator/circular_percent_indicator.dart';
// import '../../domain/entities/progress.dart';
//
// enum ProgressCardState { loading, ongoing, completed }
//
// class ProgressCard extends StatelessWidget {
//   final Progress progressData;
//   final VoidCallback onContinue;
//   final ProgressCardState state;
//
//   const ProgressCard({
//     super.key,
//     required this.progressData,
//     required this.onContinue,
//     required this.state,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     switch (state) {
//       case ProgressCardState.loading:
//         return _buildLoadingState();
//       case ProgressCardState.completed:
//         return _buildCompletedState();
//       case ProgressCardState.ongoing:
//         return _buildOngoingState();
//     }
//   }
//
//   Widget _buildLoadingState() {
//     return Card(
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
//       clipBehavior: Clip.antiAlias,
//       child: Container(
//         padding: const EdgeInsets.all(16),
//         decoration: const BoxDecoration(
//           gradient: LinearGradient(
//             colors: [
//               Color(0xFF20C997),
//               Color(0xFF18B4AC),
//             ],
//             begin: Alignment.topLeft,
//             end: Alignment.bottomRight,
//           ),
//         ),
//         child: Row(
//           children: [
//             Expanded(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Container(
//                     height: 14,
//                     width: 60,
//                     color: Colors.white24,
//                   ),
//                   const SizedBox(height: 8),
//                   Container(
//                     height: 20,
//                     width: 140,
//                     color: Colors.white30,
//                   ),
//                   const SizedBox(height: 16),
//                   Container(
//                     height: 36,
//                     width: 100,
//                     color: Colors.white24,
//                   ),
//                 ],
//               ),
//             ),
//             const CircularProgressIndicator(
//               valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget _buildOngoingState() {
//     return Card(
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
//       clipBehavior: Clip.antiAlias,
//       child: Container(
//         padding: const EdgeInsets.all(16),
//         decoration: const BoxDecoration(
//           gradient: LinearGradient(
//             colors: [Color(0xFF4FD1C5), Color(0xFF81E6D9)],
//             begin: Alignment.topLeft,
//             end: Alignment.bottomRight,
//           ),
//         ),
//         child: Row(
//           children: [
//             // Left section
//             Expanded(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Row(
//                     children: [
//                       Text(
//                         "Ongoing",
//                         style: TextStyle(
//                           color: Colors.white.withOpacity(0.9),
//                           fontSize: 14,
//                         ),
//                       ),
//                       const SizedBox(width: 6),
//                       Text(
//                         "${progressData.materialCompletions.where((m) => m.completed).length}"
//                         "/${progressData.materialCompletions.length}",
//                         style: TextStyle(
//                           color: Colors.white.withOpacity(0.7),
//                           fontSize: 14,
//                         ),
//                       ),
//                     ],
//                   ),
//                   Text(
//                     progressData.course.title,
//                     style: const TextStyle(
//                       fontSize: 18,
//                       fontWeight: FontWeight.bold,
//                       color: Colors.white,
//                     ),
//                     maxLines: 2,
//                     overflow: TextOverflow.ellipsis,
//                   ),
//                   TextButton(
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: Colors.blue[800],
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(12),
//                       ),
//                     ),
//                     onPressed: onContinue,
//                     child: const Text("Continue"),
//                   ),
//                 ],
//               ),
//             ),
//             CircularPercentIndicator(
//               radius: 40,
//               lineWidth: 10,
//               percent: progressData.progress / 100,
//               circularStrokeCap: CircularStrokeCap.round,
//               progressColor: Colors.tealAccent,
//               backgroundColor: Colors.white24,
//               center: Text(
//                 "${progressData.progress}%",
//                 style: const TextStyle(
//                   fontWeight: FontWeight.bold,
//                   color: Colors.white,
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget _buildCompletedState() {
//     return Card(
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
//       clipBehavior: Clip.antiAlias,
//       child: Container(
//         padding: const EdgeInsets.all(16),
//         decoration: const BoxDecoration(
//           gradient: LinearGradient(
//             colors: [Color(0xFF38A169), Color(0xFF48BB78)], // green gradient
//             begin: Alignment.topLeft,
//             end: Alignment.bottomRight,
//           ),
//         ),
//         child: Row(
//           children: [
//             // Left section
//             Expanded(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Row(
//                     children: const [
//                       Icon(Icons.check_circle, color: Colors.white),
//                       SizedBox(width: 6),
//                       Text(
//                         "Completed",
//                         style: TextStyle(
//                           color: Colors.white,
//                           fontSize: 14,
//                         ),
//                       ),
//                     ],
//                   ),
//                   Text(
//                     progressData.course.title,
//                     style: const TextStyle(
//                       fontSize: 18,
//                       fontWeight: FontWeight.bold,
//                       color: Colors.white,
//                     ),
//                     maxLines: 2,
//                     overflow: TextOverflow.ellipsis,
//                   ),
//                   const SizedBox(height: 8),
//                   Container(
//                     padding:
//                         const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
//                     decoration: BoxDecoration(
//                       color: Colors.white24,
//                       borderRadius: BorderRadius.circular(12),
//                     ),
//                     child: const Text(
//                       "View Certificate",
//                       style: TextStyle(color: Colors.white),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             CircularPercentIndicator(
//               radius: 40,
//               lineWidth: 10,
//               percent: 1.0,
//               circularStrokeCap: CircularStrokeCap.round,
//               progressColor: Colors.white,
//               backgroundColor: Colors.white24,
//               center: const Icon(Icons.check, color: Colors.white, size: 28),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
//
// // import 'package:flutter/material.dart';
// // import 'package:percent_indicator/circular_percent_indicator.dart';
// // import '../../domain/entities/progress.dart';
// //
// // class ProgressCard extends StatelessWidget {
// //   final Progress progressData;
// //   final VoidCallback onContinue;
// //
// //   const ProgressCard({
// //     super.key,
// //     required this.progressData,
// //     required this.onContinue,
// //   });
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return Card(
// //       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
// //       clipBehavior: Clip.antiAlias,
// //       child: Container(
// //         // height: 150,
// //         padding: const EdgeInsets.all(16),
// //         decoration: const BoxDecoration(
// //           gradient: LinearGradient(
// //             colors: [Color(0xFF4FD1C5), Color(0xFF81E6D9)],
// //             begin: Alignment.topLeft,
// //             end: Alignment.bottomRight,
// //           ),
// //         ),
// //         child: Row(
// //           children: [
// //             // Left section: Course info
// //             Expanded(
// //               child: Column(
// //                 crossAxisAlignment: CrossAxisAlignment.start,
// //                 children: [
// //                   // Status row
// //                   Row(
// //                     children: [
// //                       Text(
// //                         "Ongoing",
// //                         style: TextStyle(
// //                           color: Colors.white.withOpacity(0.9),
// //                           fontSize: 14,
// //                         ),
// //                       ),
// //                       const SizedBox(width: 6),
// //                       Text(
// //                         "${progressData.materialCompletions.where((m) => m.completed).length}"
// //                         "/${progressData.materialCompletions.length}",
// //                         style: TextStyle(
// //                           color: Colors.white.withOpacity(0.7),
// //                           fontSize: 14,
// //                         ),
// //                       ),
// //                     ],
// //                   ),
// //
// //                   // Course title
// //                   Text(
// //                     progressData.course.title,
// //                     style: const TextStyle(
// //                       fontSize: 18,
// //                       fontWeight: FontWeight.bold,
// //                       color: Colors.white,
// //                     ),
// //                     maxLines: 2,
// //                     overflow: TextOverflow.ellipsis,
// //                   ),
// //
// //                   // Instructor / org title
// //                   // Text(
// //                   //   "by ${progressData.course.orgTitle}",
// //                   //   style: TextStyle(
// //                   //     fontSize: 14,
// //                   //     color: Colors.white.withOpacity(0.85),
// //                   //   ),
// //                   // ),
// //                   // const Spacer(),
// //
// //                   // const Spacer(),
// //                   // Continue button
// //                   TextButton(
// //                     style: ElevatedButton.styleFrom(
// //                       backgroundColor: Colors.blue[800],
// //                       shape: RoundedRectangleBorder(
// //                         borderRadius: BorderRadius.circular(12),
// //                       ),
// //                       // padding: const EdgeInsets.symmetric(
// //                       //     horizontal: 16, vertical: 8),
// //                     ),
// //                     onPressed: onContinue,
// //                     child: const Text("Continue"),
// //                   ),
// //                 ],
// //               ),
// //             ),
// //
// //             // Right section: Circular progress
// //             CircularPercentIndicator(
// //               radius: 40,
// //               lineWidth: 10,
// //               percent: progressData.progress / 100,
// //               circularStrokeCap: CircularStrokeCap.round,
// //               progressColor: Colors.tealAccent,
// //               backgroundColor: Colors.white24,
// //               center: Text(
// //                 "${progressData.progress}%",
// //                 style: const TextStyle(
// //                   fontWeight: FontWeight.bold,
// //                   color: Colors.white,
// //                 ),
// //               ),
// //             ),
// //           ],
// //         ),
// //       ),
// //     );
// //   }
// // }
