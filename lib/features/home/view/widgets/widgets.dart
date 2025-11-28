import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:streamsync_lite/core/globals/globals.dart';
import 'package:streamsync_lite/core/services/cacheimages.dart';
import 'package:streamsync_lite/features/favorites/viewModel/bloc/favorites_bloc.dart';

class VideoCard extends StatelessWidget {
  final String title;
  final String channelName;
  final String postedAgo;
  final String thumbnailUrl;
  final String videoDuration;
  final VoidCallback? onTap;
  final VoidCallback? onMoreTapped;

  const VideoCard({
    Key? key,
    required this.title,
    required this.channelName,
    required this.postedAgo,
    required this.thumbnailUrl,
    required this.videoDuration,
    this.onTap,
    this.onMoreTapped,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 3,
      child: InkWell(
        onTap: onTap,
        onLongPress: onMoreTapped,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(12)),

                  child: VideoThumbnail(imageUrl: thumbnailUrl),

                  // Image.network(
                  //   thumbnailUrl,
                  //   height: 225,
                  //   width: double.infinity,
                  //   fit: BoxFit.cover,
                  // ),
                ),
                Positioned(
                  right: 10,
                  bottom: 10,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                    decoration: BoxDecoration(
                      color: Colors.black54,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      secondsToMinutesFormat(int.parse(videoDuration)),
                      style: TextStyle(color: Colors.white, fontSize: 12),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
                  ),
                  SizedBox(height: 6),
                  Text(channelName, style: TextStyle(color: Colors.grey[700])),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        postedAgo,
                        style: TextStyle(color: Colors.grey[500], fontSize: 12),
                      ),
                      InkWell(
                        onTap: onMoreTapped,
                        child: Icon(Icons.more_vert_outlined),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

String secondsToMinutesFormat(int seconds) {
  int mins = seconds ~/ 60;
  int secs = seconds % 60;
  return '$mins:${secs.toString().padLeft(2, '0')}';
}

void showVideoActions(BuildContext context, String videoID) {
  showModalBottomSheet(
    context: context,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    builder: (context) {
      return Padding(
        padding: const EdgeInsets.all(16),
        child: Wrap(
          children: [
            ListTile(
              leading: Icon(Icons.favorite_border),
              title: Text("Add to Favorites"),
              onTap: () {
                context.read<FavoritesBloc>().add(
                  AddFavoriteEvent(
                    userId: currentuser!.id,
                    videoId: videoID,
                  ),
                );Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.info_outline),
              title: Text("View Details"),
              onTap: () {},
            ),
            ListTile(
              leading: Icon(Icons.share),
              title: Text("Share Video"),
              onTap: () {},
            ),
          ],
        ),
      );
    },
  );
}
