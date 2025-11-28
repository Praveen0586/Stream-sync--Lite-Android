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
    // TODO: implement initState
    super.initState();
    context.read<FavoritesBloc>().add(LoadFavorites(currentuser!.id));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Favorites", style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.white,
        elevation: 0,
        leading: BackButton(color: Colors.black),
      ),
      body: BlocBuilder<FavoritesBloc, FavoritesState>(
        builder: (context, state) {
          if (state is FavoritesLoading) {
            return Center(child: CircularProgressIndicator());
          }

          if (state is FavoritesEmpty) {
            return Center(child: Text("No favorites yet"));
          }

          if (state is FavoritesLoaded) {
            videosList = state.videos;
            return ListView.builder(
              itemCount: state.videos.length,
              padding: EdgeInsets.all(12),
              itemBuilder: (context, index) {
                final video = state.videos[index];
                return _buildCard(context, video, index);
              },
            );
          }

          if (state is FavoritesError) {
            return Center(child: Text(state.message));
          }

          return SizedBox();
        },
      ),
    );
  }

  Widget _buildCard(BuildContext context, FavVideoModel video, int indes) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 13),
      margin: EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.07),
            blurRadius: 12,
            offset: Offset(0, 5),
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

          SizedBox(width: 12),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  video.title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                ),
                SizedBox(height: 4),
                Text(
                  "Tamil Softwares",
                  style: TextStyle(color: Colors.grey[600], fontSize: 13),
                ),
              ],
            ),
          ),

          IconButton(
            icon: Icon(Icons.favorite, color: Colors.redAccent),
            onPressed: () {
              final userId = currentuser?.id;
              if (userId == null) return; // handle null safely
              print("Removal started");
              videosList!.removeAt(indes);
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
