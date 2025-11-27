class NotificationModel {
  final String id;
  final String title;
  final String description;
  final DateTime receivedAt;
  final Map<String, dynamic> metadata; // store full metadata
  final bool isRead;

  NotificationModel({
    required this.id,
    required this.title,
    required this.description,
    required this.receivedAt,
    required this.metadata,
    required this.isRead,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
      id: json['id'].toString(),
      title: json['title'] ?? '',
      description: json['body'] ?? '',
      receivedAt: DateTime.tryParse(json['received_at'] ?? '') ?? DateTime.now(),
      metadata: Map<String, dynamic>.from(json['metadata'] ?? {}),
      isRead: (json['is_read'] ?? 0) == 1,
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "description": description,
        "received_at": receivedAt.toIso8601String(),
        "metadata": metadata,
        "is_read": isRead ? 1 : 0,
      };

  String get iconType => metadata['type'] ?? 'default';
  String? get videoId => metadata['video_id']; // helper to get video id
}
