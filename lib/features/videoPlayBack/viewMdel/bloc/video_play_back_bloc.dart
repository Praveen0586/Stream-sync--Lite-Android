import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:streamsync_lite/features/home/models/models.dart';
import 'package:streamsync_lite/features/videoPlayBack/repository/videoplayRepo.dart';

part 'video_play_back_event.dart';
part 'video_play_back_state.dart';

class VideoPlayBackBloc extends Bloc<VideoPlayBackEvent, VideoPlayBackState> {
  final Videoplayrepo repo;
  VideoPlayBackBloc(this.repo) : super(VideoPlayBackInitial()) {
    on<GetVideoByIdEvent>((event, emit) async {
      emit(VideoLoadingState());
print("heyyyyyeyeyeyeye");
      try {
        final video = await repo.fetchVideoByID(event.videoId);
        emit(VideoLoadedState(video));print("wertyuytr");

      } catch (e) {
        emit(VideoErrorState(e.toString()));
      }
    });
    on<UpdatePrgressEvent>((event, emit) async {
      try {
        await repo.updateVideoProgress(
          event.videoid,
          event.userid,
          event.prgress,
        );
        emit(ProgressUpdated(event.prgress));
      } catch (e) {
        emit(VideoProgressError("Failed to update progress"));
      }
    });

    on<GetProgressEvent>((event, emit) async {
      print("GetProgressEvent");

      try {
        final progress = await repo.getVideoProgress(
          event.videoID,
          event.userid,
        );
        print("video progress: $progress");
        emit(ProgressLoadedState(progress));
      } catch (e) {
        emit(VideoProgressError("Failed to load progress"));
      }
    });
  }
}
