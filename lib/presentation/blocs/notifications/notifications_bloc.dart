import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:push_app/domain/entities/push_message.dart';

import 'package:push_app/firebase_options.dart';

part 'notifications_event.dart';
part 'notifications_state.dart';

Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();

  print("Handling a background message: ${message.messageId}");
}

class NotificationsBloc extends Bloc<NotificationsEvent, NotificationsState> {

  FirebaseMessaging messaging = FirebaseMessaging.instance;

  NotificationsBloc() : super(const NotificationsState()) {
    on<NotificationStatusChange>( _notificationStatusChanged );
    _initialStatusCheck();
    // listener to notifications foreground
    _onForeGroundMessage();
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
  // cty60I-AQNyhZfmf5TxMKB:APA91bHbAC9zhlxViOExYuB7Fo4gJS5w5CbxcXIbFej2xcV32f9ji8CwBuVQ2vWQGScRlXmK4DybtGN28wXkLpF9VP3SMBlAmrekRE4V86CXy8-tGW8Fx5gbOo9eOPCJKwiVMxCTc9z1

  void _handleRemoteMessage( RemoteMessage message ) {
    if (message.notification == null) return;
    final notification = PushMessage(
      messageId: (message.messageId ?? '').replaceAll(':', '').replaceAll('%', ''), 
      title: message.notification?.title ?? '',
      body: message.notification?.title ?? '',
      data: message.data,
      url: Platform.isAndroid
        ? message.notification?.android?.imageUrl
        : message.notification?.apple?.imageUrl,
      sendDate: message.sentTime ?? DateTime.now(),
    );
    print(notification);
  }

  void _onForeGroundMessage() {
    FirebaseMessaging.onMessage.listen(_handleRemoteMessage);
  }
}
