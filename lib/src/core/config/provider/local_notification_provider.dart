import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart'
    show
        AndroidInitializationSettings,
        AndroidNotificationDetails,
        FlutterLocalNotificationsPlugin,
        Importance,
        InitializationSettings,
        NotificationDetails,
        NotificationResponse,
        Priority;
import 'package:proker/src/core/config/injection/injectable.dart';
import 'package:proker/src/core/utils/logger.dart';

class LocalNotificationProvider {
  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
      getIt<FlutterLocalNotificationsPlugin>();

  LocalNotificationProvider();

  Future<void> init() async {
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('ic_bg_service_small');
    const InitializationSettings initializationSettings =
        InitializationSettings(android: initializationSettingsAndroid);
    await _flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: (response) async {
        if (kDebugMode) {
          logger.d('Notification clicked with id ${response.id}');
        }
        if (response.payload != null) {
          if (response.payload == 'open_location_service_setting') {
            // GoRouter.of(navigatorKey.currentState!.context).go('/settings');
            logger.d('Open location service setting');
          } else if (response.payload == 'open_sos_service') {
            // GoRouter.of(navigatorKey.currentState!.context).go('/profile');
            logger.d('Open SOS service');
          } else {
            logger.d('Open map with jamaah_id: ${response.payload}');
          }
        }
      },
      onDidReceiveBackgroundNotificationResponse:
          _localNotificationBackgroundHandler,
    );
  }

  static Future<void> _localNotificationBackgroundHandler(
      NotificationResponse response) async {
    if (kDebugMode) {
      logger.d('Notification clicked with id ${response.id}');
    }
    if (response.payload != null) {
      if (response.payload == 'open_location_service_setting') {
        // GoRouter.of(navigatorKey.currentState!.context).go('/settings');
        logger.d('Open location service setting');
      } else if (response.payload == 'open_sos_service') {
        // GoRouter.of(navigatorKey.currentState!.context).go('/profile');
        logger.d('Open SOS service');
      } else {
        logger.d('Open map with jamaah_id: ${response.payload}');
      }
    }
  }

  Future<void> showNotification({
    required String title,
    required String body,
    String? payload,
  }) async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
      'channel_id',
      'channel_name',
      channelDescription: 'your channel description',
      icon: '@mipmap/ic_launcher',
      importance: Importance.max,
      priority: Priority.high,
    );
    const NotificationDetails platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);
    await _flutterLocalNotificationsPlugin.show(
      0,
      title,
      body,
      platformChannelSpecifics,
      payload: payload,
    );
  }

  Future<void> cancelNotification(int id) async {
    await _flutterLocalNotificationsPlugin.cancel(id);
  }
}
