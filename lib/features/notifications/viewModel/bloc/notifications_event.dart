part of 'notifications_bloc.dart';

@immutable
sealed class NotificationsEvent {}

class LoadNotificationsEvent extends NotificationsEvent {}

class MarkAllReadEvent extends NotificationsEvent {


}
class MarkNotificationReadEvent extends NotificationsEvent {
  final String notificationId;

  MarkNotificationReadEvent(this.notificationId);
}class MarkReadEvent extends NotificationsEvent {
  final String id;
  MarkReadEvent(this.id);
}
class DeleteNotificationEvent extends NotificationsEvent {
  final int notificationId;

  DeleteNotificationEvent({
    required this.notificationId,
  });
}

