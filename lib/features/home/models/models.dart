class Video {
  final String videoId;
  final String title;
  final String description;
  final String thumbnailUrl;
  final String channelId;
  final String publishedAt;
  final int durationSeconds;

  Video({
    required this.videoId,
    required this.title,
    required this.description,
    required this.thumbnailUrl,
    required this.channelId,
    required this.publishedAt,
    required this.durationSeconds,
  });

  factory Video.fromJson(Map<String, dynamic> json) {
    return Video(
      videoId: json['video_id'],
      title: json['title'],
      description: json['description'],
      thumbnailUrl: json['thumbnail_url'],
      channelId: json['channel_id'],
      publishedAt: json['published_at'],
      durationSeconds: json['duration_seconds'],
    );
  }
  Map<String, dynamic> toJson() {
  return {
    'video_id': videoId,
    'title': title,
    'description': description,
    'thumbnail_url': thumbnailUrl,
    'channel_id': channelId,
    'published_at': publishedAt,
    'duration_seconds': durationSeconds,
  };
}

}
