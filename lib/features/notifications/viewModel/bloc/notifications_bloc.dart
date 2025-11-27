import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:streamsync_lite/features/notifications/models/models.dart';
import 'package:streamsync_lite/features/notifications/repository/ntificationsrepo.dart';

part 'notifications_event.dart';
part 'notifications_state.dart';

class NotificationsBloc extends Bloc<NotificationsEvent, NotificationsState> {
  final NotificationRepository repo;

  NotificationsBloc(this.repo) : super(NotificationsInitial()) {
  //   on<LoadNotificationsEvent>((event, emit) async {
  //     emit(NotificationLoading());
  //     try {
  //       final list = await repo.getNotifications();
  //       emit(NotificationLoaded(list));
  //     } catch (_) {
  //       emit(NotificationError("Unable to load notifications"));
  //     }
  //   });

  //   on<MarkAllReadEvent>((event, emit) async {
  //     await repo.markAllAsRead();
  //     final list = await repo.getNotifications();
  //     emit(NotificationLoaded(list));
  //   });
  // }

  on<LoadNotificationsEvent>((event, emit) async {
      emit(NotificationLoading());
      try {
        final list = await repo.getNotifications();
        emit(NotificationLoaded(list));
      } catch (_) {
        emit(NotificationError("Unable to load notifications"));
      }
    });

    on<MarkAllReadEvent>((event, emit) async {
      await repo.markAllAsRead();
      final list = await repo.getNotifications();
      emit(NotificationLoaded(list));
    });
    on<MarkNotificationReadEvent>((event, emit) async {
  // Step 1: Get cached notifications
  final list = await repo.getNotifications();

  // Step 2: Update the specific notification as read
  final updated = list.map((n) {
    if (n.id == event.notificationId) {
      return NotificationModel(
        id: n.id,
        title: n.title,
        description: n.description,
        receivedAt: n.receivedAt,
        metadata: n.metadata,
        isRead: true, // mark read
      );
    }
    return n;
  }).toList();

  // Step 3: Save updated list to local storage
  await repo.local.saveToCache(updated);

  // Step 4: Emit updated state
  emit(NotificationLoaded(updated));
});

  }

  }

