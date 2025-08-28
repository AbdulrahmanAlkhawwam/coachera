import 'package:easy_localization/easy_localization.dart' hide TextDirection;
import 'package:flutter/material.dart' hide Theme, Material;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import '../core/constants/routes.dart';
import '../core/theme/theme.dart';
import '../core/utils/app_context.dart';
import '../core/service_locator/service_locator.dart';
import 'auth/presentation/manager/bloc/auth_bloc.dart';
import 'course/presentation/bloc/bloc/course_bloc.dart';
import 'home/presentation/manager/bloc/favorite_bloc.dart';
import 'home/presentation/manager/cubit/navigation_cubit.dart';
import 'home/presentation/manager/cubit/theme_notifier.dart';
import 'material/presentation/bloc/bloc/material_bloc.dart';
import 'module/presentation/bloc/bloc/module_bloc.dart';
import 'organization/presentation/bloc/bloc/organization_bloc.dart';
import 'review/presentation/bloc/bloc/review_bloc.dart';
import 'search/presentation/bloc/search_bloc.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => sl.get<AuthBloc>()
            ..add(CheckUserType())
            ..add(GetMe()),
          lazy: false,
        ),
        BlocProvider(create: (_) => sl.get<CourseBloc>(), lazy: false),
        BlocProvider(create: (_) => sl.get<NavigationCubit>(), lazy: false),
        BlocProvider(create: (_) => sl.get<FavoriteBloc>(), lazy: false),
        BlocProvider(create: (_) => sl.get<ModuleBloc>(), lazy: false),
        BlocProvider(create: (_) => sl.get<MaterialBloc>(), lazy: false),
        BlocProvider(create: (_) => sl.get<ReviewBloc>(), lazy: false),
        BlocProvider(create: (_) => sl.get<OrganizationBloc>(), lazy: false),
        BlocProvider(create: (_) => sl.get<SearchBloc>(), lazy: false),
      ],
      child: MultiBlocListener(
        listeners: [
          BlocListener<AuthBloc, AuthState>(
            listener: (context, state) {
              if (state.status == AuthStatus.error &&
                  state.message!.code == 401) {
                context.pushReplacement(Routes.login);
                context.showErrorSnackBar(massage: state.message);
              }
              if (state.status == AuthStatus.authorized) {
                context.read<FavoriteBloc>().add(GetFavorites());
              }
            },
          ),
        ],
        child: ChangeNotifierProvider(
          create: (_) => sl<ThemeNotifier>(),
          builder: (context, child) => MaterialApp(
            initialRoute: Routes.initialRoute,
            onGenerateRoute: Routes.onGenerateRoute,
            debugShowCheckedModeBanner: false,
            theme: Theme.lightTheme,
            themeMode: context.watch<ThemeNotifier>().themeMode,
            darkTheme: Theme.darkTheme,
            localizationsDelegates: context.localizationDelegates,
            supportedLocales: context.supportedLocales,
            locale: context.locale,
          ),
        ),
      ),
    );
  }
}
