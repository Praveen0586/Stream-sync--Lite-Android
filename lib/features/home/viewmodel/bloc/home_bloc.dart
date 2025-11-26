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
    on<HomeEvent>((event, emit) {
      // TODO: implement event handler
    });

    on<startLoadEvent>((event, emit) async {
      emit(loadingState());
      try {
        final List<Video> videso = await homerepo.FetchVideoByChannelId(
          channelID,
        );
        emit(LoadingsuccesState(videso));
      } catch (e) {
        emit(LoadingErrorstate());
        throw (e);
      }
    });

    on<GoToPlayScreen>((event, emit) {
      emit(GoToPlayScreenState(event.channeId));
    });
  }
}
