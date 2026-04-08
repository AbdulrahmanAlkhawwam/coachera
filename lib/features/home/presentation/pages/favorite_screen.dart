import 'package:coachera/core/constants/res.dart';
import 'package:coachera/core/constants/routes.dart';
import 'package:coachera/core/utils/app_image.dart';
import 'package:coachera/features/home/domain/entities/card_type.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/utils/app_context.dart';
import '../../../auth/presentation/manager/bloc/auth_bloc.dart';
import '../../../course/presentation/widgets/course_card.dart';
import '../manager/favorite_bloc/favorite_bloc.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({super.key});

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  @override
  void initState() {
    super.initState();
    context.read<AuthBloc>().state.userStatus != UserStatus.guest
        ? context.read<FavoriteBloc>().add(GetFavorites())
        : null;
  }

  @override
  Widget build(BuildContext context) {
    context.read<AuthBloc>().add(CheckUserType());
    context.read<AuthBloc>().state.userStatus != UserStatus.guest
        ? context.read<FavoriteBloc>().add(GetFavorites())
        : null;

    return RefreshIndicator(
      onRefresh: () async {
        context.read<FavoriteBloc>().add(GetFavorites());
      },
      child: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state.status == AuthStatus.error) {
            context.showErrorSnackBar(massage: state.message);
          }
        },
        child: BlocConsumer<FavoriteBloc, FavoriteState>(
            listener: (context, state) {},
            builder: (context, state) => switch (state.status) {
                  FavoriteStatus.loading =>
                    const Center(child: CircularProgressIndicator()),
                  _ => Scaffold(
                      appBar: AppBar(
                        title: Text("Favorites"),
                      ),
                      body: context.read<AuthBloc>().state.userStatus ==
                              UserStatus.guest
                          ? _guestHolder()
                          : state.courses.isEmpty
                              ? _emptyList()
                              : ListView.separated(
                                  itemBuilder: (context, index) => CourseCard(
                                    type: CardType.horizontal,
                                    course: context
                                        .read<FavoriteBloc>()
                                        .state
                                        .courses[index],
                                  ),
                                  separatorBuilder: (context, index) =>
                                      SizedBox(height: 8.0),
                                  itemCount: context
                                          .read<FavoriteBloc>()
                                          .state
                                          .courses
                                          .length ,
                                ),
                    ),
                }),
      ),
    );
  }

  Widget _guestHolder() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Spacer(),
            AppImage(
              context.isDark ? Res.favoriteDark : Res.favoriteLight,
              height: 160,
            ),
            const SizedBox(height: 16),
            Text(
              "You are Guest",
              style: context.textTheme.headlineSmall
                  ?.copyWith(color: context.colors.onSurface),
            ),
            const SizedBox(height: 8),
            Text(
              textAlign: TextAlign.center,
              "You're browsing as a guest right now. \nPlease log in to access your favorite items",
              style: context.textTheme.bodyMedium?.copyWith(
                  color: context.colors.onPrimaryContainer.withAlpha(160)),
            ),
            Spacer(),
            FilledButton(
                onPressed: () =>
                    context.read<FavoriteBloc>().add(GetFavorites()),
                child: Text("Lets Try Again !")),
            const SizedBox(height: 8),
            OutlinedButton(
              onPressed: () => context.pushReplacement(Routes.login),
              child: Text('Login now !'),
            ),
            Spacer(),
          ],
        ),
      ),
    );
  }

  Widget _emptyList() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Spacer(),
            AppImage(
              context.isDark ? Res.searchDark : Res.searchLight,
              height: 160,
            ),
            const SizedBox(height: 16),
            Text(
              "No Favorite",
              style: context.textTheme.headlineSmall
                  ?.copyWith(color: context.colors.onSurface),
            ),
            const SizedBox(height: 8),
            Text(
              textAlign: TextAlign.center,
              "You're browsing as a guest right now. \nPlease log in to access your favorite items",
              style: context.textTheme.bodyMedium?.copyWith(
                  color: context.colors.onPrimaryContainer.withAlpha(160)),
            ),
            Spacer(),
            FilledButton(
                onPressed: () =>
                    context.read<FavoriteBloc>().add(GetFavorites()),
                child: Text("Lets Try Again !")),
            const SizedBox(height: 8),
            OutlinedButton(
              onPressed: () => context.push (Routes.recommendedCourses),
              child: Text('View Courses'),
            ),
            Spacer(),
          ],
        ),
      ),
    );
  }
}
