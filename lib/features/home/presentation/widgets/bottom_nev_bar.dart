import 'package:flutter/material.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';

class BottomNevBar extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;

  const BottomNevBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: onTap,
      items: const [
        BottomNavigationBarItem(
          icon: Icon(TablerIcons.smart_home),
          label: "Home",
        ),
        BottomNavigationBarItem(
          icon: Icon(TablerIcons.player_play),
          label: "Course",
        ),
        BottomNavigationBarItem(
          icon: Icon(TablerIcons.heart),
          label: "Favorite",
        ),
        BottomNavigationBarItem(
          icon: Icon(TablerIcons.user),
          label: "Profile",
        ),
      ],
    );
  }
}

// import 'package:coachera/features/home/presentation/manager/cubit/navigation_cubit.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';
//
// class BottomNevBar extends StatelessWidget {
//
//   const BottomNevBar({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<NavigationCubit, NavigationState>(
//         builder: (context, state) {
//       final cubit = context.read<NavigationCubit>();
//       return BottomNavigationBar(
//         currentIndex: cubit.screenIndex,
//         onTap: cubit.changeIndex,
//         items: const [
//           BottomNavigationBarItem(
//             icon: Icon(TablerIcons.smart_home),
//             label: "Home",
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(TablerIcons.player_play),
//             label: "Course",
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(TablerIcons.heart),
//             label: "Favorite",
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(TablerIcons.user),
//             label: "Profile",
//           ),
//         ],
//       );
//     });
//   }
// }
