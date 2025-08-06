import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';

import '../../../../auth/presentation/pages/profile_screen.dart';
import '../../../../course/presentation/pages/courses_screen.dart';
import '../../pages/favorite_screen.dart';
import '../../pages/home_screen.dart';

part 'navigation_state.dart';

class NavigationCubit extends Cubit<NavigationState> {
  NavigationCubit() : super(InitState());
  int screenIndex = 0;

  void changeIndex(int index) {
    screenIndex = index;
    emit(ChangeIndex());
  }

  Widget getCurrentScreen() => switch (screenIndex) {
        0 => HomeScreen(),
        1 => RecommendationCoursesScreen(),
        2 => FavoriteScreen(),
        _ => ProfileScreen(),
      };
}
