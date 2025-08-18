import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../manager/cubit/navigation_cubit.dart';
import '../widgets/bottom_nev_bar.dart';

class MainScreen extends StatelessWidget {
  MainScreen({super.key, this.page});

  int? page;

  @override
  Widget build(BuildContext context) {
    context.read<NavigationCubit>().changeIndex(page ?? 0);
    page = null;
    return BlocBuilder<NavigationCubit, NavigationState>(
        builder: (context, state) {
      final cubit = context.read<NavigationCubit>();
      return Scaffold(
        bottomNavigationBar: BottomNevBar(),
        body: cubit.getCurrentScreen(),
      );
    });
  }
}
