import 'package:firebase_core/firebase_core.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

import 'package:push_app/firebase_options.dart';

part 'notifications_event.dart';
part 'notifications_state.dart';

class NotificationsBloc extends Bloc<NotificationsEvent, NotificationsState> {

  FirebaseMessaging messaging = FirebaseMessaging.instance;

  NotificationsBloc() : super(const NotificationsState()) {
    on<NotificationStatusChange>( _notificationStatusChanged );
    _initialStatusCheck();
  }

  static  Future<void> initializeFCM () async {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  }

  void _notificationStatusChanged(NotificationStatusChange  event, Emitter<NotificationsState>  emit ) {
    emit(
      state.copyWith(
        status: event.status
      )
    );
    _getFCMToken();
  } 

  void requestPermissions() async {
     final settings = await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    add(  NotificationStatusChange( settings.authorizationStatus ));
  }

  void _initialStatusCheck () async {
    final setting = await messaging.getNotificationSettings();
    add(  NotificationStatusChange( setting.authorizationStatus ) );
  }

  void _getFCMToken() async {
    final setting = await messaging.getNotificationSettings();

    if ( setting.authorizationStatus != AuthorizationStatus.authorized ) return;

    final token = await messaging.getToken();

    print(token);
  }
}
