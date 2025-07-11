import 'package:coachera/core/service_locator/category_services.dart';
import 'package:get_it/get_it.dart';

import './core_services.dart';
import 'auth_services.dart';
import 'course_services.dart';
import 'favorite_services.dart';
import 'home_services.dart';
import 'settings_services.dart';

final sl = GetIt.instance;

Future<void> initializeApp() async {
  await initializeAuthServices(sl);
  // await initializeCartServices(sl);
  await initializeCourseServices(sl);
  await initializeCoreServices(sl);
  await initializeHomeServices(sl);
  await initializeCategoryServices(sl);
  await initializeFavoriteServices(sl);
  // await initializeFileServices(sl);
  // await initializeMainServices(sl);
  // await initializeOrderServices(sl);
  // await initializeProductServices(sl);
  await initializeSettingsServices(sl);
  // await initializeShopServices(sl);
  // await initializeUserServices(sl);
}
