import 'package:flutter_local_notifications/flutter_local_notifications.dart';




class LocalNotifications {
  
  static Future<void> requestPermissionLocalNotifications () async {
    FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
          FlutterLocalNotificationsPlugin();
    await flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<
      AndroidFlutterLocalNotificationsPlugin>()?.requestNotificationsPermission();
  }

  static Future<void> initializeLocalNotifications () async {
    final flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    const initializeSettingsAndroid = AndroidInitializationSettings( 'app_icon' );

    const initializationSettings = InitializationSettings(
      android: initializeSettingsAndroid,
    );
    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,

    );
  }

  static void showLocalNotification( {
    required int id,
    String? title,
    String? body,
    String? data,
  }) {
    const androidDetails = AndroidNotificationDetails(
      'channelId', 
      'channelName',
      playSound: true,
      sound: RawResourceAndroidNotificationSound('notification'),
      importance: Importance.max,
      priority: Priority.high,
    );

    const notificationsDetails = NotificationDetails(
      android: androidDetails,
    );

    final flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

    flutterLocalNotificationsPlugin.show(id, title, body, notificationsDetails, payload: data);
  }
  
}