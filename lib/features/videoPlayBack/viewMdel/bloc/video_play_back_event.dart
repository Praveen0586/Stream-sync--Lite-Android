part of 'video_play_back_bloc.dart';

@immutable
sealed class VideoPlayBackEvent {}

class UpdatePrgressEvent extends VideoPlayBackEvent {
  final String videoid;
  final String userid;
  final int prgress;
  UpdatePrgressEvent(this.videoid, this.userid, this.prgress);
}

class GetProgressEvent extends VideoPlayBackEvent {
  final String videoID;
  final String userid;

  GetProgressEvent(this.videoID, this.userid);
}
