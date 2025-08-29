import 'package:get_it/get_it.dart';

import './core_services.dart';
import 'auth_services.dart';
import 'category_services.dart';
import 'course_services.dart';
import 'favorite_services.dart';
import 'home_services.dart';
import 'instructor_services.dart';
import 'learning_path_services.dart';
import 'material_services.dart';
import 'module_services.dart';
import 'organization_services.dart';
import 'review_services.dart';
import 'search_services.dart';
import 'settings_services.dart';

final sl = GetIt.instance;

Future<void> initializeApp() async {
  await initializeAuthServices(sl);
  await initializeCourseServices(sl);
  await initializeCoreServices(sl);
  await initializeHomeServices(sl);
  await initializeCategoryServices(sl);
  await initializeFavoriteServices(sl);
  await initializeModuleServices(sl);
  await initializeReviewServices(sl);
  await initializeMaterialServices(sl);
  await initializeOrganizationServices(sl);
  await initializeSettingsServices(sl);
  await initializeSearchServices(sl);
  await initializeInstructorServices(sl);
  await initializeLearningPathServices(sl);
}
