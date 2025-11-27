import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:streamsync_lite/features/home/view/homescreen.dart';
import 'package:streamsync_lite/features/notifications/viewModel/bloc/notifications_bloc.dart';
import 'package:streamsync_lite/features/videoPlayBack/views/videoPlayScreen.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  Widget _iconSelector(String type) {
    switch (type) {
      case "video":
        return Icon(Icons.play_circle_fill, color: Colors.blue, size: 36);
      case "star":
        return Icon(Icons.star, color: Colors.amber, size: 36);
      case "bell":
        return Icon(Icons.notifications, color: Colors.blue, size: 36);
      default:
        return Icon(Icons.update, color: Colors.grey, size: 36);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<NotificationsBloc>().add(LoadNotificationsEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(color: Colors.black),
        title: const Text(
          "Notifications",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: [
          TextButton(
            onPressed: () {
              context.read<NotificationsBloc>().add(MarkAllReadEvent());
            },
            child: const Text("Mark all as read"),
          ),
        ],
      ),

      body: BlocBuilder<NotificationsBloc, NotificationsState>(
        builder: (context, state) {
          if (state is NotificationLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is NotificationLoaded) {
            return ListView.separated(
              itemCount: state.notifications.length,
              separatorBuilder: (_, __) => const Divider(height: 1),
              itemBuilder: (context, index) {
                final n = state.notifications[index];

                return InkWell(
                  onTap: () {
                    // Mark the notification as read
                    context.read<NotificationsBloc>().add(
                      MarkNotificationReadEvent(n.id),
                    );

                    // Navigate to video if metadata has videoId
                    if (n.videoId != null) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) =>
                              CourseVideoScreen(videoID: n.videoId!),
                        ),
                      );
                    }
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _iconSelector(n.iconType),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                n.title,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                n.description,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(color: Colors.grey.shade600),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                formatTimeAgo(n.receivedAt),
                                style: TextStyle(
                                  color: Colors.grey.shade500,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ),
                        if (!n.isRead)
                          const Icon(
                            Icons.circle,
                            color: Colors.blue,
                            size: 10,
                          ),
                      ],
                    ),
                  ),
                );
              },
            );
          }

          return const Center(child: Text("No Notifications"));
        },
      ),
    );
  }
}
