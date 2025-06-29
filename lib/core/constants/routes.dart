import 'package:flutter/material.dart';

import '../../features/auth/presentation/pages/forget_password_screen.dart';
import '../../features/auth/presentation/pages/login_screen.dart';
import '../../features/auth/presentation/pages/register_screen.dart';
import '../../features/category/presentation/pages/search_screen.dart';
import '../../features/home/presentation/pages/home_screen.dart';
import '../service_locator/service_locator.dart';

class Endpoint {
  static String login = '/auth/login';
  static String logout = '/auth/logout';
  static String courses = '/courses';
}

class Routes {
  Routes._();

  static const String splash = "/splash";
  static const String home = "/home";

  // static const String onBoarding = "/on-boarding";
  // static const String habits = "/habits";
  // static const String habitPage = "/habits/view";
  // static const String habitEdit = "/habits/edit";
  // static const String habitsLibrary = "/habits/library";
  static const String search = "/home/search";

  // static const String firstHabitWizard = "/habits/first-wizard";
  // static const String settings = "/settings";
  // static const String periodsSettings = "/settings/periods";
  // static const String categoriesSettings = "/settings/categories";
  // static const String about = "/about";
  // static const String subscription = "/subscription";
  // static const String subscriptionExpired = "/subscription/expired";
  // static const String subscribed = "/subscription/subscribed";
  static const String login = "/auth";
  static const String register = "/auth/register";
  static const String forgotPassword = "/auth/forgot-password";
  static const String confirmEmail = "/auth/confirm-email";
  static const String resetPassword = "/auth/reset-password";

  // static const String profile = "/settings/profile";
  // static const String groups = "/home/groups";
  // static const String coachGroups = "/home/coach-groups";
  // static const String joinGroup = "/home/groups/join";
  // static const String coachGroupDetails = "/home/coach-groups/group-details";
  static const String initialRouteKey = "initial_route";
  static const String initialArgsKey = "initial_route_args";

  // static const String coachHabitDetails = "/home/coach-groups/habit-details";
  // static const String comments = "/home/habits/view/comment-page";

  static String get initialRoute => sl<String>(instanceName: initialRouteKey);

  // static Map? get _initialArgs {
  //   if (!sl.isRegistered<Map>(instanceName: initialArgsKey)) {
  //     return null;
  //   }
  //   final args = sl<Map>(instanceName: initialArgsKey);
  //   sl.unregister<Map>(instanceName: initialArgsKey);
  //   return args;
  // }

  static final routes = {
    home: (context, arguments) => HomeScreen(),
    search: (context, arguments) => SearchScreen(),
    // splash: (context, arguments) => SplashScreen(),
    // onBoarding: (context, arguments) => OnBoardingScreen(),
    // habits: (context, arguments) => UserHabitsPage(),
    // habitPage: (context, arguments) => HabitPage(),
    // habitEdit: (context, arguments) => HabitEditPage(),
    // habitsLibrary: (context, arguments) => HabitsLibraryPage(),
    // firstHabitWizard: (context, arguments) => FirstHabitWizardScreen(),
    // settings: (context, arguments) => SettingsPage(),
    // periodsSettings: (context, arguments) => PeriodsSettingsPage(),
    // categoriesSettings: (context, arguments) => CategoriesSettingsPage(),
    // about: (context, arguments) => AboutAppPage(),
    // subscription: (context, arguments) => SubscriptionPage(),
    // subscriptionExpired: (context, arguments) => SubscriptionExpiredPage(),
    // subscribed: (context, arguments) => SubscribedPage(),
    login: (context, arguments) => LoginScreen(),
    register: (context, arguments) => RegisterScreen(),
    // coachGroups: (context, arguments) => CoachGroupsPage(),
    // coachGroupDetails: (context, arguments) => GroupDetailsPage(
    //   group: arguments?["group"] as Group,
    // ),
    // coachHabitDetails: (context, arguments) => HabitDetailsPage(
    //   habit: arguments?["habit"] as Habit,
    //   groupId: arguments?["groupId"] as int,
    // ),
    // comments: (context, arguments) => CommentPage(
    //   isCoach: arguments?["isCoach"] as bool,
    //   habit: arguments?["habit"] as Habit,
    // ),
    forgotPassword: (context, arguments) => ForgetPasswordScreen(),
    // confirmEmail: (context, arguments) {
    //   final initialArgs = _initialArgs;
    //   final token, type;
    //   if (initialArgs != null) {
    //     type = initialArgs["type"];
    //     token = initialArgs["token"];
    //   } else {
    //     type = arguments?["type"] as ConfirmType;
    //     token = arguments?["token"] as String?;
    //   }
    //   final email = arguments?["email"] as String?;
    //
    //   return ConfirmEmailScreen(type, token: token, email: email);
    // },
    // resetPassword: (context, arguments) {
    //   final initialArgs = _initialArgs;
    //   String? token =
    //       initialArgs != null ? initialArgs["token"] : arguments?["token"];
    //   if (token == null) {
    //     return LoginScreen();
    //   }
    //
    //   return ResetPasswordScreen(token);
    // },
    // profile: (context, arguments) => ProfileScreen(),
    // groups: (context, arguments) => GroupsPage(),
    // joinGroup: (context, arguments) {
    //   final initialArgs = _initialArgs;
    //   String uuid =
    //       initialArgs != null ? initialArgs["uuid"] : arguments?["uuid"];
    //   return JoinGroupPage(uuid: uuid);
    // },
  };

  static Route? onGenerateRoute(RouteSettings settings) {
    if (settings.name == "/") {
      return null;
    }
    // if (settings.name == home || settings.name == onBoarding) {
    //   return PageRouteBuilder(
    //     pageBuilder: (context, __, ___) => routes[settings.name]!(context, settings.arguments),
    //     transitionDuration: const Duration(milliseconds: 500),
    //     settings: settings,
    //     transitionsBuilder: (context, animation, __, child) {
    //       return FadeTransition(opacity: animation, child: child);
    //     },
    //   );
    // }
    if (!routes.containsKey(settings.name)) {
      return _onUnknownRoute(settings);
    }
    return MaterialPageRoute(
      builder: (context) => routes[settings.name]!(context, settings.arguments),
      settings: settings,
    );
  }

  static Route? _onUnknownRoute(settings) {
    return MaterialPageRoute(
      builder: (_) => Scaffold(
        body: Center(
          child: Text("No route defined for ${settings.name}"),
        ),
      ),
    );
  }
}
