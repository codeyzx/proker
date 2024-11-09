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
import 'package:proker/core/config/injection/injectable.dart';

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
          print('Notification clicked with id ${response.id}');
        }
        if (response.payload != null) {
          if (response.payload == 'open_location_service_setting') {
            // GoRouter.of(navigatorKey.currentState!.context).go('/settings');
            print('Open location service setting');
          } else if (response.payload == 'open_sos_service') {
            // GoRouter.of(navigatorKey.currentState!.context).go('/profile');
            print('Open SOS service');
          } else {
            print('Open map with jamaah_id: ${response.payload}');
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
      print('Notification clicked with id ${response.id}');
    }
    if (response.payload != null) {
      if (response.payload == 'open_location_service_setting') {
        // GoRouter.of(navigatorKey.currentState!.context).go('/settings');
        print('Open location service setting');
      } else if (response.payload == 'open_sos_service') {
        // GoRouter.of(navigatorKey.currentState!.context).go('/profile');
        print('Open SOS service');
      } else {
        print('Open map with jamaah_id: ${response.payload}');
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
