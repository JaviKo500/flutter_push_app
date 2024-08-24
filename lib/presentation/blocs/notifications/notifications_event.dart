part of 'notifications_bloc.dart';

sealed class NotificationsEvent {
  const NotificationsEvent();
}

class NotificationStatusChange extends NotificationsEvent {
  final AuthorizationStatus status;
  NotificationStatusChange( this.status ); 
}

class NotificationReceived extends NotificationsEvent {
  final PushMessage notification;
  NotificationReceived( this.notification ); 
}