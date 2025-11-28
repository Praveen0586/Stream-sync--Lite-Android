part of 'favorites_bloc.dart';

abstract class FavoritesEvent {
  @override
  List<Object?> get props => [];
}

class LoadFavorites extends FavoritesEvent {
  final int userId;

  LoadFavorites(this.userId);

  @override
  List<Object?> get props => [userId];
}

class AddFavoriteEvent extends FavoritesEvent {
  final int userId;
  final String videoId;

  AddFavoriteEvent({required this.userId, required this.videoId});
}

class RemoveFavoriteEvent extends FavoritesEvent {
  final int userId;
  final String videoId;

  RemoveFavoriteEvent({required this.userId, required this.videoId});
}
