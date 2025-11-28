class FavVideoModel {
  final String videoId;
  final String title;
  final String description;
  final String thumbnailUrl;
  final int durationSeconds;
  final DateTime createdAt;

  FavVideoModel({
    required this.videoId,
    required this.title,
    required this.description,
    required this.thumbnailUrl,
    required this.durationSeconds,
    required this.createdAt,
  });

  factory FavVideoModel.fromJson(Map<String, dynamic> json) {
    return FavVideoModel(
      videoId: json['video_id'],
      title: json['title'],
      description: json['description'],
      thumbnailUrl: json['thumbnail_url'],
      durationSeconds: json['duration_seconds'],
      createdAt: DateTime.parse(json['created_at']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'video_id': videoId,
      'title': title,
      'description': description,
      'thumbnail_url': thumbnailUrl,
      'duration_seconds': durationSeconds,
      'created_at': createdAt.toIso8601String(),
    };
  }
}
