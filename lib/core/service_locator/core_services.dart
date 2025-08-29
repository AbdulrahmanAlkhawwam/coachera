import 'dart:io';

import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../constants/env.dart';
import '../constants/routes.dart';
import '../constants/strings.dart';
import '../helpers/database_helper.dart';
import '../helpers/http/http_service.dart';
import '../helpers/storage_helper.dart';

Future<void> initializeCoreServices(GetIt sl) async {
  WidgetsFlutterBinding.ensureInitialized();

  if (Platform.isAndroid) {
    SecurityContext.defaultContext
        .setTrustedCertificatesBytes(Uint8List.fromList(isrgRootX1.codeUnits));
  }

  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      systemNavigationBarColor: Colors.transparent,
    ),
  );
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  await EasyLocalization.ensureInitialized();
  // await Firebase.initializeApp(
  //   options: DefaultFirebaseOptions.currentPlatform,
  // );
  // Stripe.publishableKey = Env.stripeKey;
  // await Stripe.instance.applySettings();

  // await Firebase.initializeApp();
  // final notifications = NotificationsHelperImpl.initializedInstance;
  // sl.registerLazySingleton<NotificationsHelper>(() => notifications);
  // sl.registerLazySingleton<NotificationService>(() => NotificationService());
  // await NotificationService.init();

  final db = await DatabaseHelperImpl.instance();
  sl.registerLazySingleton<DatabaseHelper>(
    () => db,
    dispose: (db) => db.close(),
  );

  SharedPreferences preferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => preferences);
  sl.registerLazySingleton<StorageHelper>(() => StorageHelperImpl(sl()));
  sl.registerSingleton<String>(
      preferences.getString(accessTokenKey) != null &&
              (preferences.getBool(guestKey) != null ||
                  preferences.getBool(guestKey) != false)
          ? Routes.main
          : Routes.login,
      instanceName: Routes.initialRouteKey);

  sl.registerLazySingleton<HttpService>(
    () {
      return HttpService(
        host: Env.host,
        basePath: "/${Env.baseUrl}",
        client: http.Client(),
        storage: sl(),
      );
    },
    dispose: (httpHelper) => httpHelper.close(),
  );

  // sl.registerLazySingleton<MultipartHttpHelper>(
  //   () => MultipartHttpHelperImpl(
  //     host: Env.host,
  //     basePath: "/api",
  //     storage: sl(),
  //   ),
  // );
}
