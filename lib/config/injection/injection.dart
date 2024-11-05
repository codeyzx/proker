import 'dart:async' show Future;
import 'package:flutter_local_notifications/flutter_local_notifications.dart'
    show
        AndroidFlutterLocalNotificationsPlugin,
        FlutterLocalNotificationsPlugin;
import 'package:get_it/get_it.dart' show GetIt;
import 'package:injectable/injectable.dart' show InjectableInit;
import 'package:proker/config/provider/local_notification_provider.dart';
import 'package:proker/data/repositories/auth_repository_impl.dart';

final GetIt getIt = GetIt.instance;

@InjectableInit()
Future<void> initDependencyInjection(navigatorKey) async {
  getIt.registerSingleton<FlutterLocalNotificationsPlugin>(
      FlutterLocalNotificationsPlugin());
  getIt<FlutterLocalNotificationsPlugin>()
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.requestNotificationsPermission();

  getIt.registerSingleton<LocalNotificationProvider>(
      LocalNotificationProvider());
  getIt<LocalNotificationProvider>().init();

  getIt.registerSingleton(AuthRepositoryImpl());
}
