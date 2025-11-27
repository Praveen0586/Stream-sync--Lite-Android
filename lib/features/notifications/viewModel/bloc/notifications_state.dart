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

class NotificationDeletedState extends NotificationsState {
  final int deletedId;

  NotificationDeletedState(this.deletedId);
}

class NotificationDeleteErrorState extends NotificationsState {
  final String message;

  NotificationDeleteErrorState(this.message);
}class NotificationDeletingState extends NotificationsState {}



