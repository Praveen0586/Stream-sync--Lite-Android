part of 'home_bloc.dart';

@immutable
sealed class HomeState {}

final class HomeInitial extends HomeState {}

class loadingState extends HomeState {}

class LoadingsuccesState extends HomeState {
  final List<Video> videoList;  final int notificationCount;

  LoadingsuccesState(this.videoList, this.notificationCount);
  
}



class LoadingErrorstate extends HomeState {}

