part of 'notifications_bloc.dart';

@immutable
sealed class NotificationsState {}

final class NotificationsInitial extends NotificationsState {}



class NotificationLoading extends NotificationsState {}

class NotificationLoaded extends NotificationsState {
  final List<NotificationModel> notifications;
  NotificationLoaded(this.notifications);
}

class NotificationError extends NotificationsState {
  final String message;
  NotificationError(this.message);
}
