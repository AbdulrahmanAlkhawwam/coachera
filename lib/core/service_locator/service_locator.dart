import 'package:get_it/get_it.dart';

import './core_services.dart';
import 'auth_services.dart';

final sl = GetIt.instance;

Future<void> initializeApp() async {
  await initializeAuthServices(sl);
  // await initializeCartServices(sl);
  await initializeCoreServices(sl);
  // await initializeFavoriteServices(sl);
  // await initializeFileServices(sl);
  // await initializeMainServices(sl);
  // await initializeOrderServices(sl);
  // await initializeProductServices(sl);
  // await initializeSettingsServices(sl);
  // await initializeShopServices(sl);
  // await initializeUserServices(sl);
}
