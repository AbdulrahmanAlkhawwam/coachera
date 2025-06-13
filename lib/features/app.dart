import 'package:coachera/features/auth/presentation/pages/register_screen.dart';
import 'package:coachera/features/auth/presentation/pages/temp_screen.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart' hide Theme;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import 'package:coachera/core/theme/theme.dart';
import '../core/service_locator/service_locator.dart';
import 'auth/presentation/bloc/bloc/auth_bloc.dart';
import 'auth/presentation/pages/login_screen.dart';
import 'auth/presentation/pages/verification_screen.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => sl.get<AuthBloc>())
        // ..add(CheckAuth()), lazy: false),
        // BlocProvider(create: (_) => sl.get<OrderBloc>(), lazy: false),
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
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: Theme.lightTheme,
          themeMode: ThemeMode.dark,
          // themeMode: context.watch<ThemeNotifier>().themeMode,
          darkTheme: Theme.darkTheme,
          localizationsDelegates: context.localizationDelegates,
          supportedLocales: context.supportedLocales,
          locale: context.locale,
          // home: BlocBuilder<AuthBloc, AuthState>(
          //   builder: (context, state) {
          //     return switch (state.status) {
          // AuthStatus.checking || AuthStatus.init => LoadingScreen(),
          // AuthStatus.notVerified => OtpScreen(),
          // AuthStatus.authorized => MainScreen(),
          // _ => LoginScreen(),
          // };
          // },
          home: TempScreen(), // ),
        ),
      ),
    );
  }
}
