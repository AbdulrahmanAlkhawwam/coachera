import 'package:coachera/core/utils/app_context.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/constants/routes.dart';
import '../../../auth/presentation/manager/bloc/auth_bloc.dart';
import '../manager/cubit/navigation_cubit.dart';
import '../widgets/bottom_nev_bar.dart';

class MainScreen extends StatelessWidget {
  MainScreen({super.key, this.page});

  int? page;

  @override
  Widget build(BuildContext context) {
    context.read<NavigationCubit>().changeIndex(page ?? 0);
    page = null;
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if ((state.status == AuthStatus.error &&
                state.message!.code == 500 &&
                state.userStatus != UserStatus.guest) ||
            (state.status == AuthStatus.error &&
                state.message!.code == 401 &&
                state.userStatus != UserStatus.guest)) {
          context.pushReplacement(Routes.login);
          context.showErrorSnackBar(massage: state.message);
        }
      },
      child: BlocBuilder<NavigationCubit, NavigationState>(
          builder: (context, state) {
        final cubit = context.read<NavigationCubit>();
        return Scaffold(
          bottomNavigationBar: BottomNevBar(),
          body: cubit.getCurrentScreen(),
        );
      }),
    );
  }
}
