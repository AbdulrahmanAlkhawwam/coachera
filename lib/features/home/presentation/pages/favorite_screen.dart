import 'package:coachera/core/constants/res.dart';
import 'package:coachera/core/constants/routes.dart';
import 'package:coachera/core/utils/app_image.dart';
import 'package:coachera/features/app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';

import '../../../../core/utils/app_context.dart';
import '../../../auth/presentation/manager/bloc/auth_bloc.dart';
import '../manager/bloc/favorite_bloc.dart';

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
    return Scaffold(
      appBar: AppBar(
        title: Text("Favorites"),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(TablerIcons.bell_ringing),
          )
        ],
      ),
      body: context.read<AuthBloc>().state.userStatus == UserStatus.guest
          ? Center(
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
                      "No favorite yet!",
                      style: context.textTheme.headlineSmall
                          ?.copyWith(color: context.colors.onSurface),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      textAlign: TextAlign.center,
                      "You're browsing as a guest right now. \nPlease log in to access your favorite items",
                      style: context.textTheme.bodyMedium?.copyWith(
                          color:
                              context.colors.onPrimaryContainer.withAlpha(160)),
                    ),
                    Spacer(),
                    OutlinedButton(
                      onPressed: () => context.pushReplacement(Routes.login),
                      child: Text('Login now !'),
                    ),
                    Spacer(),
                  ],
                ),
              ),
            )
          : ListView.separated(
              itemBuilder: (context, index) => Container(
                width: double.infinity,
                height: 80,
                color: context.colors.primary,
              ),
              separatorBuilder: (context, index) => SizedBox(height: 8.0),
              itemCount: 10,
            ),
    );
  }
}
