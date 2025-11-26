part of 'home_bloc.dart';

@immutable
sealed class HomeState {}

final class HomeInitial extends HomeState {}

class loadingState extends HomeState {}

class LoadingsuccesState extends HomeState {
  final List<Video> videoList;
  LoadingsuccesState(this.videoList);
}

// class GoToPlayScreenState extends HomeState {
//   final String VideoId;
//   GoToPlayScreenState(this.VideoId);
// }

class LoadingErrorstate extends HomeState {}
