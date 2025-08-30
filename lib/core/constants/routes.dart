import 'package:flutter/material.dart';

import '../../features/auth/presentation/pages/forget_password_screen.dart';
import '../../features/auth/presentation/pages/login_screen.dart';
import '../../features/auth/presentation/pages/register_screen.dart';
import '../../features/auth/presentation/pages/reset_password_screen.dart';
import '../../features/auth/presentation/pages/verification_screen.dart';
import '../../features/course/presentation/pages/coarse_details_screen.dart';
import '../../features/course/presentation/pages/recommended_courses_screen.dart';
import '../../features/home/presentation/pages/faq_screen.dart';
import '../../features/home/presentation/pages/home_screen.dart';
import '../../features/home/presentation/pages/main_screen.dart';
import '../../features/home/presentation/pages/notification_screen.dart';
import '../../features/home/presentation/pages/privacy_condition_screen.dart';
import '../../features/home/presentation/pages/settings_screen.dart';
import '../../features/instructor/presentation/pages/instructors_screen.dart';
import '../../features/learningPath/presentation/pages/learning_paths_screen.dart';
import '../../features/material/presentation/pages/quiz_lesson_screen.dart';
import '../../features/material/presentation/pages/video_lesson_screen.dart';
import '../../features/organization/presentation/pages/organizations_screen.dart';
import '../../features/payment/presentation/pages/payment_screen.dart';
import '../../features/review/presentation/pages/reviews_screen.dart';
import '../../features/search/presentation/pages/search_screen.dart';
import '../service_locator/service_locator.dart';

class Endpoint {
  /// notifications
  static String deviceToken = '/notifications/register-device';
  static String unreadCount = '/notifications/unread-count';
  static String notifications = '/notifications/my';
  static String markNotificationsRead = '/notifications/mark-read';

  /// search
  static String getEntities = '/search/entities';

  static String search(String entity) => '/search/$entity';

  /// Favorite
  static String getFavorites = '/favorites/student';

  static String addFavorite(courseId) => '/favorites/$courseId/student';

  static String deleteFavorite(courseId) => '/favorites/$courseId';

  static String getFavorite(courseId) => '/favorites/check/$courseId';

  /// instructor
  static String instructors = '/instructors';

  /// Auth
  static String login = '/auth/login';
  static String logout = '/auth/logout';
  static String me = '/students/me';
  static String registerUser = '/auth/register';
  static String forgetPassword = '/auth/forgot-password';
  static String validateOTP = '/auth/validate-otp';

  /// course
  static String enroll(courseId) => '/enrollments/student/$courseId';
  static String courses = '/courses';
  static String recommendedCourses = '/courses/recommended';
  static String categories = '/categories';
  static String changePassword = '/auth/reset-password';

  /// review
  static String courseReviews(courseId) => '/reviews/course/$courseId';
  static String reviews = '/reviews/my-reviews';

  /// organization
  static String getOrganizations = '/organizations';

  static String getOrganization(orgId) => '/organizations/$orgId';

  static String courseModules(courseId) => '/modules/courses/$courseId';

  /// material
  static String getMaterials(materialId) => '/materials/$materialId';
  static String submitQuiz = '/quizzes/verify';

  /// learning path
  static String learningPaths = '/learning-paths';
}

class Routes {
  Routes._();

  static const String splash = "/splash";
  static const String home = "/home";
  static const String main = "/main";
  static const String courseDetails = '/courses/course';
  static const String videoLesson = "/courses/course/video-material";
  static const String quizLesson = '/courses/course/quiz-material';
  static const String payment = '/profile/payment';
  static const String reviews = '/profile/reviews';
  static const String instructor = '/home/instructor';
  static const String learningPaths = '/home/learning-path';
  static const String organizations = '/home/organizations';
  static const String organizationDetails = '/home/organizations/organization';
  static const String notification = '/home/notification';
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
    videoLesson: (context, arguments) =>
        VideoLessonScreen(lesson: arguments['material']),
    quizLesson: (context, arguments) =>
        QuizLessonScreen(quiz: arguments["material"]),
    instructor: (context, arguments) => InstructorScreen(),
    courseDetails: (context, arguments) =>
        CourseDetailsScreen(course: arguments['course']),
    recommendedCourses: (context, argument) => RecommendedCoursesScreen(),
    notification: (context, argument) => NotificationScreen(),
    organizations: (context, argument) => OrganizationsScreen(),
    main: (context, arguments) => MainScreen(page: arguments?['page'] ?? 0),
    setting: (context, argument) => SettingsScreen(),
    payment: (context, argument) => PaymentsScreen(),
    reviews: (context, argument) => ReviewsScreen(),
    learningPaths: (context, argument) => LearningPathsScreen(),
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
