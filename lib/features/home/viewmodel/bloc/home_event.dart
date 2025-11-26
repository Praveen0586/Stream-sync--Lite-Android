part of 'home_bloc.dart';

@immutable
sealed class HomeEvent {}

class startLoadEvent extends HomeEvent {}

class VideosLoadingEvent extends HomeEvent {}

class LoadSuccesEvent extends HomeEvent {}

class GoToPlayScreen extends HomeEvent {
  final String channeId;
  GoToPlayScreen(this.channeId);
}
