import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:streamsync_lite/features/favorites/repository/favrepo.dart';
import 'package:streamsync_lite/features/home/models/models.dart';
import 'favorites_state.dart';
part 'favorites_event.dart';

class FavoritesBloc extends Bloc<FavoritesEvent, FavoritesState> {
  final FavoritesRepository repo;

  FavoritesBloc(this.repo) : super(FavoritesLoading()) {
    on<LoadFavorites>(_onLoadFavorites);
    on<AddFavoriteEvent>(_onAddFavorite);
    on<RemoveFavoriteEvent>(_onRemoveFavorite);
  }
Future<void> _onLoadFavorites(
  LoadFavorites event,
  Emitter<FavoritesState> emit,
) async {
  emit(FavoritesLoading());
print("loading");
  try {
    final videos = await repo.getVideoDetails(); 
    if (videos.isEmpty) {
      emit(FavoritesEmpty());
      return;
    }
    emit(FavoritesLoaded(videos));
  } catch (e) {
    emit(FavoritesError(e.toString()));
  }
}


  Future<void> _onAddFavorite(
    AddFavoriteEvent event,
    Emitter<FavoritesState> emit,
  ) async {
    await repo.addFavorite(event.userId, event.videoId);
    emit(FavoriteAdded());
  }

  Future<void> _onRemoveFavorite(
    RemoveFavoriteEvent event,
    Emitter<FavoritesState> emit,
  ) async {
    await repo.removeFavorite(event.userId, event.videoId);

 try {
    final videos = await repo.getVideoDetails(); 
    if (videos.isEmpty) {
      emit(FavoritesEmpty());
      return;
    }
    emit(FavoritesLoaded(videos));
  } catch (e) {
    emit(FavoritesError(e.toString()));
  }
  }
}
