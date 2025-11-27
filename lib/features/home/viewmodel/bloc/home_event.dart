part of 'home_bloc.dart';

@immutable
sealed class HomeEvent {}

class startLoadEvent extends HomeEvent {}

class VideosLoadingEvent extends HomeEvent {}

class LoadSuccesEvent extends HomeEvent {}


class RefreshEvent extends HomeEvent {}


