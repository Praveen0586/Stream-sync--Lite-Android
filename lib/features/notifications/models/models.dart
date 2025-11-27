class NotificationModel {
  final String id;
  final String title;
  final String description;
  final String timeAgo;
  final String iconType;
  final bool isRead;
  final String? videoId;

  NotificationModel({
    required this.id,
    required this.title,
    required this.description,
    required this.timeAgo,
    required this.iconType,
    required this.isRead,
    this.videoId,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
      id: json['id'].toString(),
      title: json['title'] ?? '',
      description: json['body'] ?? '',
      timeAgo: json['received_at'] ?? '',
      iconType: json['metadata']?['type'] ?? 'default',
      isRead: (json['is_read'] ?? 0) == 1,
      videoId: json['metadata']?['video_id'],
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "description": description,
        "timeAgo": timeAgo,
        "iconType": iconType,
        "isRead": isRead,
        "videoId": videoId,
      };
}
