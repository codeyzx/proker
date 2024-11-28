// lib/models/feed_item.dart

class FeedItem {
  final String status;
  final String profileName;
  final String time;
  final String eventName;
  final String description;
  final String image;

  FeedItem({
    required this.status,
    required this.profileName,
    required this.time,
    required this.eventName,
    required this.description,
    required this.image,
  });
}
