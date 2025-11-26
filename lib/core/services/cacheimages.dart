import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class VideoThumbnail extends StatelessWidget {
  final String imageUrl;

  const VideoThumbnail({required this.imageUrl, super.key});

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: imageUrl,
      height: 225,
      width: double.infinity,
      placeholder: (context, url) =>
          Center(child: const CircularProgressIndicator()),
      errorWidget: (context, url, error) => const Icon(Icons.error),
      fit: BoxFit.cover,
    );
  }
}
