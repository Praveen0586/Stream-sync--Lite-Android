import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:streamsync_lite/features/home/models/models.dart';
import 'package:streamsync_lite/features/home/repositories/Homerepo.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final Homerepo homerepo;
  final channelID = "UCeMpxGQm9c8Zyz_fjEAxXnQ";
  HomeBloc(this.homerepo) : super(HomeInitial()) {
    on<startLoadEvent>((event, emit) async {
      emit(loadingState());
      try {
        final List<Video> videso = await homerepo.FetchVideoByChannelId(
          channelID,
        ); final count = await homerepo.fetchNotifications_count();
        emit(LoadingsuccesState(videso,count));
      } catch (e) {
        emit(LoadingErrorstate());
      }
    });
    on<RefreshEvent>((event, emit) async {
      emit(loadingState());
      try {
  final List<Video> videso = await homerepo.FetchVideoByChannelId(
          channelID,
        );        final count = await homerepo.fetchNotifications_count();
        emit(LoadingsuccesState(videso,count));
      } catch (e) {
        emit(LoadingErrorstate());
      }
    });

  }
}
