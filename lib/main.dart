import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:proker/firebase_options.dart';
import 'package:proker/src/app.dart';
import 'package:proker/src/core/config/injection/injectable.dart';

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

  // Firebase Setup
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  // FirebaseNotificationProvider();

  // Background Service Setup
  // await getIt<BackgroundServiceClient>().initializeService();

  // Dependency Injection Setup
  configureDependencies();

  runApp(App());
}
