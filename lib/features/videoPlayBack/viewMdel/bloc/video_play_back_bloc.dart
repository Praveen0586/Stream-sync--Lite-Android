import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'video_play_back_event.dart';
part 'video_play_back_state.dart';

class VideoPlayBackBloc extends Bloc<VideoPlayBackEvent, VideoPlayBackState> {
  VideoPlayBackBloc() : super(VideoPlayBackInitial()) {
    on<VideoPlayBackEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
