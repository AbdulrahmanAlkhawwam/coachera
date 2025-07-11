import 'package:coachera/features/home/presentation/manager/bloc/favorite_bloc.dart';
import 'package:coachera/features/home/presentation/manager/cubit/navigation_cubit.dart';
import 'package:easy_localization/easy_localization.dart' hide TextDirection;
import 'package:flutter/material.dart' hide Theme;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import '../core/constants/routes.dart';
import '../core/theme/theme.dart';
import '../core/service_locator/service_locator.dart';
import 'auth/presentation/manager/bloc/auth_bloc.dart';
import 'course/presentation/bloc/bloc/course_bloc.dart';
import 'home/presentation/manager/cubit/theme_notifier.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => sl.get<AuthBloc>(), lazy: false),
        BlocProvider(create: (_) => sl.get<CourseBloc>(), lazy: false),
        BlocProvider(create: (_) => sl.get<NavigationCubit>(), lazy: false),
        BlocProvider(create: (_) => sl.get<FavoriteBloc>(), lazy: false),
        // BlocProvider(create: (_) => sl.get<UserBloc>(), lazy: false),
        // BlocProvider(create: (_) => sl.get<ProductBloc>(), lazy: false),
        // BlocProvider(create: (_) => sl.get<ShopBloc>(), lazy: false),
        // BlocProvider(create: (_) => sl.get<FileBloc>(), lazy: false),
        // BlocProvider(create: (_) => sl.get<CartBloc>(), lazy: false),
        // BlocProvider(create: (_) => sl.get<AuthPresCubit>()),
      ],
      child: MultiBlocListener(
        listeners: [
          BlocListener<AuthBloc, AuthState>(
            listener: (context, state) {
              if (state.status == AuthStatus.authorized) {
                // context.read<CourseBloc>().add(GetCourses());
                // context.read<UserBloc>().add(GetAccount());
                // context.read<OrderBloc>().add(GetOrders());
                // context.read<ShopBloc>().add(GetShops());
                // context.read<ShopBloc>().add(GetShopsCategories());
                // context.read<ProductBloc>().add(GetProductsCategories());
                // context.read<CartBloc>().add(GetCart());
              }
            },
          ),
        ],
        child: MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (_) => sl<ThemeNotifier>()),
          ],
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
