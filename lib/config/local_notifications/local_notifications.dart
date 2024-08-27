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
  
}