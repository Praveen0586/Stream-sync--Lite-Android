import 'package:streamsync_lite/features/favorites/model/favModel.dart';
import 'package:streamsync_lite/features/home/models/models.dart';

abstract class FavoritesState   {
  @override
  List<Object?> get props => [];
}

class FavoritesLoading extends FavoritesState {}

class FavoritesLoaded extends FavoritesState {    
  final List<FavVideoModel> videos;

  FavoritesLoaded(this.videos);

  @override
  List<Object?> get props => [videos];
}

class FavoritesEmpty extends FavoritesState {}

class FavoritesError extends FavoritesState {
  final String message;
  FavoritesError(this.message);
}

class FavoriteAdded extends FavoritesState {}

class FavoriteRemoved extends FavoritesState {}
