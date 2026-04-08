import 'package:coachera/core/utils/app_context.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/constants/routes.dart';
import '../../../auth/presentation/manager/bloc/auth_bloc.dart';
import '../manager/cubit/navigation_cubit.dart';
import '../manager/favorite_bloc/favorite_bloc.dart';
import '../widgets/bottom_nev_bar.dart';

// ignore: must_be_immutable
class MainScreen extends StatefulWidget {
  MainScreen({super.key, this.page});

  int? page;

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: widget.page ?? 0);
    context.read<NavigationCubit>().changeIndex(widget.page ?? 0);
    widget.page = null;
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<FavoriteBloc, FavoriteState>(
      listener: (context, state) {
        if ((state.status == FavoriteStatus.error &&
            state.message!.code == 401 &&
            context.read<AuthBloc>().state.userStatus != UserStatus.guest)) {
          context.pushReplacement(Routes.login);
          context.showErrorSnackBar(massage: state.message);
        }
      },
      child: BlocBuilder<NavigationCubit, NavigationState>(
        builder: (context, state) {
          final cubit = context.read<NavigationCubit>();

          return Scaffold(
            bottomNavigationBar: BottomNevBar(
              currentIndex: state.index,
              onTap: (index) {
                _pageController.animateToPage(
                  index,
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                );
                cubit.changeIndex(index);
              },
            ),
            body: PageView(
              controller: _pageController,
              onPageChanged: (index) => cubit.changeIndex(index),
              children: cubit.screens,
            ),
          );
        },
      ),
    );
  }
}
