import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../auth/presentation/pages/profile_screen.dart';
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
