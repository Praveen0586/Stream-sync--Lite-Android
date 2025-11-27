part of 'video_play_back_bloc.dart';

@immutable
sealed class VideoPlayBackState {}

final class VideoPlayBackInitial extends VideoPlayBackState {}

class UpdateProgreeState extends VideoPlayBackState {}

class ProgressUpdated extends VideoPlayBackState {
  final int progress;
  ProgressUpdated(this.progress);
}

class VideoProgressError extends VideoPlayBackState {
  final String message;
  VideoProgressError(this.message);
}

class ProgressLoadedState extends VideoPlayBackState {
  final int progress;
  ProgressLoadedState(this.progress);
}

class VideoLoadedState extends VideoPlayBackState {
  final Video video;
  VideoLoadedState(this.video);
}

class VideoLoadingState extends VideoPlayBackState {}

class VideoErrorState extends VideoPlayBackState {
  final String message;
  VideoErrorState(this.message);
}
