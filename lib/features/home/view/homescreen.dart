import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:streamsync_lite/features/home/view/widgets/widgets.dart';
import 'package:streamsync_lite/features/home/viewmodel/bloc/home_bloc.dart';
import 'package:streamsync_lite/features/videoPlayBack/views/videoPlayScreen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    context.read<HomeBloc>().add(startLoadEvent());
    return BlocConsumer<HomeBloc, HomeState>(
      listener: (context, state) {
        if (state is GoToPlayScreenState) {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) {
                return Videoplayscreen(videoID: state.VideoId);
              },
            ),
          );
        }
      },
      builder: (context, state) {
        if (state is loadingState) {
          return Scaffold(
            appBar: AppBar(title: Text("Stream Sync"), centerTitle: true),
            body: Center(child: CircularProgressIndicator.adaptive()),
          );
        } else if (state is LoadingsuccesState) {
          return Scaffold(
            appBar: AppBar(title: Text("Stream Sync"), centerTitle: true),
            body: RefreshIndicator(
              onRefresh: () async {
                context.read<HomeBloc>().add(startLoadEvent());
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

                      context.read<HomeBloc>().add(
                        GoToPlayScreen(video.videoId),
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
            appBar: AppBar(title: Text("Stream Sync"), centerTitle: true),
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
