import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:streamsync_lite/core/globals/globals.dart';
import 'package:streamsync_lite/features/favorites/model/favModel.dart';
import 'package:streamsync_lite/features/favorites/viewModel/bloc/favorites_bloc.dart';
import 'package:streamsync_lite/features/favorites/viewModel/bloc/favorites_state.dart';
class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({super.key});

  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  List<FavVideoModel>? videosList;

  @override
  void initState() {
    super.initState();
    context.read<FavoritesBloc>().add(LoadFavorites(currentuser!.id));
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context); // get current theme

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        title: Text("Favorites", style: theme.textTheme.titleLarge),
        backgroundColor: theme.appBarTheme.backgroundColor,
        elevation: theme.appBarTheme.elevation,
        leading: BackButton(color: theme.appBarTheme.foregroundColor),
      ),
      body: BlocBuilder<FavoritesBloc, FavoritesState>(
        builder: (context, state) {
          if (state is FavoritesLoading) {
            return Center(child: CircularProgressIndicator(color: theme.primaryColor));
          }

          if (state is FavoritesEmpty) {
            return Center(
              child: Text("No favorites yet", style: theme.textTheme.bodyMedium),
            );
          }

          if (state is FavoritesLoaded) {
            videosList = state.videos;
            return ListView.builder(
              itemCount: state.videos.length,
              padding: const EdgeInsets.all(12),
              itemBuilder: (context, index) {
                final video = state.videos[index];
                return _buildCard(context, video, index, theme);
              },
            );
          }

          if (state is FavoritesError) {
            return Center(child: Text(state.message, style: theme.textTheme.bodyMedium));
          }

          return const SizedBox();
        },
      ),
    );
  }

  Widget _buildCard(BuildContext context, FavVideoModel video, int index, ThemeData theme) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 13),
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: theme.cardColor,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: theme.brightness == Brightness.light
                ? Colors.black.withOpacity(0.07)
                : Colors.black.withOpacity(0.3),
            blurRadius: 12,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(14),
            child: Image.network(
              video.thumbnailUrl,
              width: 120,
              height: 80,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  video.title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 4),
                Text(
                  "Tamil Softwares",
                  style: theme.textTheme.bodySmall,
                ),
              ],
            ),
          ),
          IconButton(
            icon: const Icon(Icons.favorite, color: Colors.redAccent),
            onPressed: () {
              final userId = currentuser?.id;
              if (userId == null) return;
              videosList!.removeAt(index);
              context.read<FavoritesBloc>().add(
                    RemoveFavoriteEvent(userId: userId, videoId: video.videoId),
                  );
            },
          ),
        ],
      ),
    );
  }
}
