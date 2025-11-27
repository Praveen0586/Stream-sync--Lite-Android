import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:streamsync_lite/features/home/view/widgets/widgets.dart';
import 'package:streamsync_lite/features/home/viewmodel/bloc/home_bloc.dart';
import 'package:streamsync_lite/features/notifications/views/noificationscreen.dart';
import 'package:streamsync_lite/features/videoPlayBack/views/videoPlayScreen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<HomeBloc>().add(startLoadEvent());
    });
  }

  int notificationCount = 0;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeBloc, HomeState>(
      listener: (context, state) {},
      builder: (context, state) {
        if (state is loadingState) {
          return Scaffold(
            appBar: AppBar(title: Text("Stream Sync"), centerTitle: true),
            body: Center(child: CircularProgressIndicator.adaptive()),
          );
        } else if (state is LoadingsuccesState) {
          notificationCount = state.notificationCount;
          return Scaffold(
            appBar: AppBar(
              title: Text("Stream Sync"),
              centerTitle: true,
              actions: [
                Stack(
                  children: [
                    IconButton(
                      icon: Icon(Icons.notifications_none_outlined),
                      onPressed: () {
                        Navigator.push(
                          context,
                          CupertinoPageRoute(
                            builder: (_) => NotificationsScreen(),
                          ),
                        );
                      },
                    ),
                    if (notificationCount > 0)
                      Positioned(
                        right: 6,
                        top: 1,
                        child: Container(
                          padding: EdgeInsets.all(1),
                          decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          constraints: BoxConstraints(
                            minWidth: 18,
                            minHeight: 18,
                          ),
                          child: Text(
                            '$notificationCount',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                  ],
                ),
              ],
            ),
            body: RefreshIndicator(
              onRefresh: () async {
                context.read<HomeBloc>().add(RefreshEvent());
              },
              child: ListView.builder(
                physics: AlwaysScrollableScrollPhysics(),
                itemCount: state.videoList.length,
                itemBuilder: (context, index) {
                  final video = state.videoList[index];

                  return VideoCard(
                    title: video.title,
                    channelName: "Tamil Softwares",
                    postedAgo: video.publishedAt,
                    thumbnailUrl: video.thumbnailUrl,
                    videoDuration: video.durationSeconds.toString(),
                    onTap: () {
                      print("Play: ${video.title}");

                      Navigator.push(
                        context,
                      CupertinoPageRoute(
                            builder: (_) => CourseVideoScreen(videoID: video.videoId),
                          ),
                      );
                      // Navigate to player
                    },
                    onMoreTapped: () {
                      showVideoActions(context, video.videoId);
                    },
                  );
                },
              ),
            ),
          );
        } else if (state is LoadingErrorstate) {
          return Scaffold(
            appBar: AppBar(
              title: Text("Stream Sync"),
              centerTitle: true,
              actions: [
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      CupertinoPageRoute(builder: (_) => NotificationsScreen()),
                    );
                  },
                  child: Icon(Icons.notifications_none_outlined),
                ),
              ],
            ),
            body: Center(
              child: Container(
                child: TextButton(
                  child: Text("Fetching Try Again "),
                  onPressed: () {
                    context.read<HomeBloc>().add(startLoadEvent());
                  },
                ),
              ),
            ),
          );
        }
        // else {
        //   context.read<HomeBloc>().add(startLoadEvent());
        //   return Scaffold(
        //     appBar: AppBar(title: Text("Stream Sync"), centerTitle: true),
        //   );
        // }
        else {}
        return Scaffold(
          appBar: AppBar(title: Text("Stream Sync"), centerTitle: true),
        );
      },
    );
  }
}

String formatTimeAgo(DateTime dateTime) {
  final now = DateTime.now();
  final difference = now.difference(dateTime);

  if (difference.inSeconds < 60) {
    return 'just now';
  }

  if (difference.inMinutes < 60) {
    int minutes = difference.inMinutes;
    return '$minutes ${minutes == 1 ? 'minute' : 'minutes'} ago';
  }

  if (difference.inHours < 24) {
    int hours = difference.inHours;
    return '$hours ${hours == 1 ? 'hour' : 'hours'} ago';
  }

  if (difference.inDays < 7) {
    int days = difference.inDays;
    return '$days ${days == 1 ? 'day' : 'days'} ago';
  }

  int weeks = (difference.inDays / 7).floor();
  if (weeks < 4) {
    return '$weeks ${weeks == 1 ? 'week' : 'weeks'} ago';
  }

  int months = (difference.inDays / 30).floor();
  if (months < 12) {
    return '$months ${months == 1 ? 'month' : 'months'} ago';
  }

  int years = (difference.inDays / 365).floor();
  return '$years ${years == 1 ? 'year' : 'years'} ago';
}
