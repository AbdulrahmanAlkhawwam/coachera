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
