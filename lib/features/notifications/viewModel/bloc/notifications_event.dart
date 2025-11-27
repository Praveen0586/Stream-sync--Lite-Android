part of 'notifications_bloc.dart';

@immutable
sealed class NotificationsEvent {}

class LoadNotificationsEvent extends NotificationsEvent {}

class MarkAllReadEvent extends NotificationsEvent {}
class MarkNotificationReadEvent extends NotificationsEvent {
  final String notificationId;

  MarkNotificationReadEvent(this.notificationId);
}