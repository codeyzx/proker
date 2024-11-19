import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:proker/firebase_options.dart';
import 'package:proker/src/app.dart';
import 'package:proker/src/core/config/adapter/adapter_conf.dart';
import 'package:proker/src/core/config/injection/injectable.dart';
import 'package:proker/src/core/utils/observer.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Request notification permission if it's not granted
  if (await Permission.notification.isDenied ||
      await Permission.notification.isPermanentlyDenied ||
      await Permission.notification.isRestricted ||
      await Permission.notification.isLimited) {
    await Permission.notification.request();
  }

  // Intl Setup
  await initializeDateFormatting(Platform.localeName);
  Intl.defaultLocale = Platform.localeName;

  // Orientation Setup
  await SystemChrome.setPreferredOrientations(
    [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown],
  );

  await Future.wait([
    // Firebase Setup
    Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform),
    Hive.initFlutter(),
    getTemporaryDirectory().then((path) async {
      HydratedBloc.storage = await HydratedStorage.build(
        storageDirectory: path,
      );
    }),
  ]);

  // FirebaseNotificationProvider();

  // Background Service Setup
  // await getIt<BackgroundServiceClient>().initializeService();

  // Hive Adapter Setup
  configureAdapter();

  // Dependency Injection Setup
  configureDependencies();

  setup();

  Bloc.observer = AppBlocObserver();

  runApp(App());
}
