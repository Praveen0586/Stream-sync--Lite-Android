import 'package:streamsync_lite/core/globals/globals.dart';
import 'package:streamsync_lite/features/notifications/models/models.dart';
import 'package:streamsync_lite/features/notifications/services/localNotifications.dart';
import 'package:streamsync_lite/features/notifications/services/notificationremote.dart';

class NotificationRepository {
  final NotificationRemoteService remote;
  final NotificationLocalService local;

  NotificationRepository({required this.remote, required this.local});

  Future<List<NotificationModel>> getNotifications() async {
    try {
      print("fetchNotifications");
      final list = await remote.fetchNotifications();
      await local.saveToCache(list);
      return list;
    } catch (_) {
      return await local.loadFromCache();
    }
  }

  // Future<void> markAllAsRead() async {
  //   final list = await local.loadFromCache();
  //   final updated = list
  //       .map(
  //         (n) => NotificationModel(
  //           metadata: n.metadata,
  //           receivedAt: n.receivedAt,
  //           id: n.id,
  //           title: n.title,
  //           description: n.description,

  //           isRead: true,
  //         ),
  //       )
  //       .toList();

  //   await local.saveToCache(updated);
  // }
  Future<void> markAsRead(String id) => remote.markAsRead(id);

  Future<void> markAllAsRead() async {
    final notifications = await getNotifications();
    final ids = notifications.map((n) => n.id).toList();
    remote.markAllAsRead(ids);
  }

  Future<bool> deleteNotification(int nid) async {
  return await  remote.deleteNotification(nid, currentuser!.id);
  }
}
