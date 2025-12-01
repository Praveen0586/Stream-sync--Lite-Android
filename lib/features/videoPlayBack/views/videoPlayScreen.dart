import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:share_plus/share_plus.dart';
import 'package:streamsync_lite/core/globals/globals.dart';
import 'package:streamsync_lite/features/home/models/models.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../viewMdel/bloc/video_play_back_bloc.dart';

class CourseVideoScreen extends StatefulWidget {
  final String videoID;
  const CourseVideoScreen({super.key, required this.videoID});

  @override
  State<CourseVideoScreen> createState() => _CourseVideoScreenState();
}

class _CourseVideoScreenState extends State<CourseVideoScreen> {
  late YoutubePlayerController _controller;
  bool isLiked = false;
  int lastProgress = 0;
  int resumePos = 0;
  Video? videoData;
  bool _isPlayerReady = false;
  @override
  void initState() {
    super.initState();

    final bloc = context.read<VideoPlayBackBloc>();
    bloc.add(GetVideoByIdEvent(widget.videoID));

    /// 1. Load Saved Progress
    bloc.add(GetProgressEvent(widget.videoID, currentuser!.id.toString()));

    /// 2. Create Player
    _controller = YoutubePlayerController(
      initialVideoId: widget.videoID,
      flags: YoutubePlayerFlags(
        disableDragSeek: false,
        autoPlay: true,
        controlsVisibleAtStart: true,
        enableCaption: true,
        isLive: false,
      ),
    );
  }

  void _trackProgress() {
    if (!_controller.value.isPlaying) return;

    final currentSec = _controller.value.position.inSeconds;
    if ((currentSec - lastProgress).abs() >= 5) {
      lastProgress = currentSec;

      context.read<VideoPlayBackBloc>().add(
        UpdatePrgressEvent(
          widget.videoID,
          currentuser!.id.toString(),
          currentSec,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<VideoPlayBackBloc, VideoPlayBackState>(
      listener: (context, state) {
        if (state is ProgressLoadedState) {
          resumePos = state.progress;

          if (_isPlayerReady) {
            _controller.seekTo(Duration(seconds: resumePos));
          }
        } else if (state is VideoLoadedState) {
          setState(() {
            videoData = state.video;
          });
        }
      },
      child: YoutubePlayerBuilder(
        player: YoutubePlayer(
          controller: _controller,
          onReady: () {
            _isPlayerReady = true;
            _controller.addListener(_trackProgress);

            if (resumePos > 0) {
              _controller.seekTo(Duration(seconds: resumePos));
            }
          },
        ),
        builder: (context, player) {
          return Scaffold(
            appBar: AppBar(
              title: const Text("Video Player"),
              actions: [
              
                IconButton(
                  icon: const Icon(Icons.share),
                  onPressed: () =>
                      Share.share("Watch: https://youtu.be/${widget.videoID}"),
                ),
              ],
            ),

            body: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                player,

                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    videoData?.title ?? 'Loading...',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: Text(
                          "Tamil Softwares",
                          style: TextStyle(fontSize: 20, color: Colors.grey),
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        PopupMenuButton<double>(
                          icon: const Icon(Icons.speed),
                          onSelected: (v) => _controller.setPlaybackRate(v),
                          itemBuilder: (context) => const [
                            PopupMenuItem(value: 0.5, child: Text("0.5x")),
                            PopupMenuItem(value: 1.0, child: Text("1.0x")),
                            PopupMenuItem(value: 1.5, child: Text("1.5x")),
                            PopupMenuItem(value: 2.0, child: Text("2.0x")),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Text(videoData?.description ?? "Loading..."),
                ),

                const SizedBox(height: 10),

                const Divider(),
              ],
            ),

          
          );
        },
      ),
    );
  }
}
