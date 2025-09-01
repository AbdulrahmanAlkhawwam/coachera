import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../auth/presentation/pages/profile_screen.dart';
import '../../../../course/presentation/pages/recommended_courses_screen.dart';
import '../../../../course/presentation/pages/user_courses_screen.dart';
import '../../pages/favorite_screen.dart';
import '../../pages/home_screen.dart';

part 'navigation_state.dart';

class NavigationCubit extends Cubit<NavigationState> {
  NavigationCubit() : super(const NavigationState());

  final List<Widget> screens = [
    HomeScreen(),
    UserCoursesScreen(),
    FavoriteScreen(),
    ProfileScreen(),
  ];

  void changeIndex(int newIndex) {
    emit(state.copyWith(index: newIndex));
  }
}

// import 'package:bloc/bloc.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:meta/meta.dart';
//
// import '../../../../auth/presentation/pages/profile_screen.dart';
// import '../../../../course/presentation/pages/recommended_courses_screen.dart';
// import '../../pages/favorite_screen.dart';
// import '../../pages/home_screen.dart';
//
// part 'navigation_state.dart';
//
// class NavigationCubit extends Cubit<NavigationState> {
//   NavigationCubit() : super(InitState());
//   int screenIndex = 0;
//
//   void changeIndex(int index) {
//     screenIndex = index;
//     emit(ChangeIndex());
//   }
//
//   List<Widget> screens = [
//     HomeScreen(),
//     RecommendedCoursesScreen(),
//     FavoriteScreen(),
//     ProfileScreen(),
//   ];
//
//   Widget getCurrentScreen() => switch (screenIndex) {
//         0 => HomeScreen(),
//         1 => RecommendedCoursesScreen(),
//         2 => FavoriteScreen(),
//         _ => ProfileScreen(),
//       };
// }
