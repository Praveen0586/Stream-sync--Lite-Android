
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:streamsync_lite/core/globals/globals.dart';
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
              setState(() {
                
              });
            },
            child: const Text("Mark all as read"),
          ),
        ],
      ),

      body: BlocListener<NotificationsBloc, NotificationsState>(
        listener: (context, state) {
          if (state is NotificationDeletedState) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text("Notification deleted")));
          }

          if (state is NotificationDeleteErrorState) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.message)));
          }
        },

        child: BlocBuilder<NotificationsBloc, NotificationsState>(
          builder: (context, state) {
            if (state is NotificationLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            if (state is NotificationLoaded) {
              if (state.notifications.isEmpty) {
                return const Center(child: Text("No Notifications"));
              }

              return ListView.separated(
                itemCount: state.notifications.length,
                separatorBuilder: (_, __) => Divider(),
                itemBuilder: (context, index) {
                  var n = state.notifications[index];

                  return Dismissible(
                    key: ValueKey("notif_${n.id}_${index}"),
                    direction: DismissDirection.endToStart,

                    background: Container(
                      color: Colors.red,
                      alignment: Alignment.centerRight,
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: const Icon(Icons.delete, color: Colors.white),
                    ),

                    onDismissed: (_) {
                      final bloc = context.read<NotificationsBloc>();
                      state.notifications.removeAt(index);

                      bloc.add(
                        DeleteNotificationEvent(
                          notificationId: int.parse(n.id),
                        ),
                      );
                    },

                    child: ListTile(
                      leading: _iconSelector(n.iconType),
                      title: Text(n.title),
                      subtitle: Text(n.description),
                      trailing: n.isRead
                          ? null
                          : Icon(Icons.circle, color: Colors.blue, size: 10),

                      onTap: () {
                        print(n.isRead);
                        // if (!n.isRead) {
                        //   setState(() {
                        //     n.isRead = true;
                        //   });
                        // }

                        print(global_apitoken);
                        setState(() {});
                        context.read<NotificationsBloc>().add(
                          MarkReadEvent(n.id),
                        );

                        if (n.videoId != null && n.videoId!.isNotEmpty) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) =>
                                  CourseVideoScreen(videoID: n.videoId!),
                            ),
                          );
                        }
                      },
                    ),
                  );
                },
              );
            }

            return const Center(child: Text("No Notifications"));
          },
        ),
      ),
    );
  }
}
