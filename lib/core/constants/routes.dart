import 'package:coachera/features/course/presentation/pages/courses_screen.dart';
import 'package:coachera/features/home/presentation/pages/faq_screen.dart';
import 'package:coachera/features/home/presentation/pages/privacy_condition_screen.dart';
import 'package:flutter/material.dart';

import '../../features/auth/presentation/pages/forget_password_screen.dart';
import '../../features/auth/presentation/pages/login_screen.dart';
import '../../features/auth/presentation/pages/register_screen.dart';
import '../../features/auth/presentation/pages/reset_password_screen.dart';
import '../../features/auth/presentation/pages/verification_screen.dart';
import '../../features/category/presentation/pages/search_screen.dart';
import '../../features/course/presentation/pages/coarse_details_screen.dart';
import '../../features/home/presentation/pages/home_screen.dart';
import '../../features/home/presentation/pages/main_screen.dart';
import '../../features/home/presentation/pages/settings_screen.dart';
import '../service_locator/service_locator.dart';

class Endpoint {
  static String login = '/auth/login';
  static String forgetPassword = '/auth/forgot-password';
  static String validateOTP = '/auth/validate-otp';
  static String logout = '/auth/logout';
  static String courses = '/courses';
  static String recommendedCourses = '/courses/recommended';
  static String categories = '/categories';
  static String getFavorites = '/favorites/student';
  static String changePassword = '/auth/reset-password';

  static String getOrganization(orgId) => '/api/organizations/$orgId';

  static String removeFavorite(courseId) => '/api/favorites/delete/$courseId';

  static String addFavorite(courseId) => '/favorites/$courseId/student';
}

class Routes {
  Routes._();

  static const String splash = "/splash";
  static const String home = "/home";
  static const String main = "/main";
  static const String courseDetails = '/courses/course';
  static const String courses = "/courses";
  static const String search = "/home/search";
  static const String setting = '/profile/setting';
  static const String faq = '/profile/setting/faq';
  static const String privacy = '/profile/setting/privacy';
  static const String login = "/auth";
  static const String register = "/auth/register";
  static const String forgotPassword = "/auth/forgot-password";
  static const String confirmEmail = "/auth/confirm-email";
  static const String resetPassword = "/auth/reset-password";
  static const String validateOtp = '/auth/otp';
  static const String profile = "/profile";
  static const String favorite = "/favorite";
  static const String recommendedCourses = "/recommended-courses";
  static const String initialRouteKey = "initial_route";
  static const String initialArgsKey = "initial_route_args";

  static String get initialRoute => sl<String>(instanceName: initialRouteKey);

  static final routes = {
    home: (context, arguments) => HomeScreen(),
    search: (context, arguments) => SearchScreen(),
    faq: (context, arguments) => FAQScreen(),
    privacy: (context, arguments) => PrivacyConditionScreen(),
    // courses: (context, arguments) => CoursesScreen(),
    courseDetails: (context, arguments) =>
        CourseDetailsScreen(course: arguments['course']),
    recommendedCourses: (context, argument) => RecommendationCoursesScreen(),
    main: (context, arguments) => MainScreen(page: arguments?['page'] ?? 0),
    setting: (context, argument) => SettingsScreen(),
    validateOtp: (context, argument) =>
        VerificationScreen(email: argument['email']),
    resetPassword: (context, argument) => ResetPasswordScreen(
          email: argument['email'],
          passkey: argument['passkey'],
        ),
    login: (context, arguments) => LoginScreen(),
    register: (context, arguments) => RegisterScreen(),
    forgotPassword: (context, arguments) => ForgetPasswordScreen(),
  };

  static Route? onGenerateRoute(RouteSettings settings) {
    if (settings.name == "/") {
      return null;
    }
    if (settings.name == home /*|| settings.name == onBoarding*/) {
      return PageRouteBuilder(
        pageBuilder: (context, __, ___) =>
            routes[settings.name]!(context, settings.arguments),
        transitionDuration: const Duration(milliseconds: 500),
        settings: settings,
        transitionsBuilder: (context, animation, __, child) {
          return FadeTransition(opacity: animation, child: child);
        },
      );
    }
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
