import 'package:proker/src/features/event/domain/entities/event_entity.dart';

class EventModel extends EventEntity {
  const EventModel({
    super.id,
    super.title,
    super.description,
    super.status,
    super.startDate,
    super.endDate,
    super.location,
    super.createdBy,
    super.type,
    super.benefits,
    super.bannerUrl,
    super.category,
    super.upvoteCount,
    super.documentationUrl,
    super.galleryUrls,
    super.timeline,
  });

  factory EventModel.fromJson(Map<String, dynamic> json) {
    return EventModel(
      id: json["id"] as String?,
      title: json["title"] as String?,
      description: json["description"] as String?,
      status: json["status"] as String?,
      startDate: json["start_date"] != null
          ? DateTime.parse(json["start_date"] as String)
          : null,
      endDate: json["end_date"] != null
          ? DateTime.parse(json["end_date"] as String)
          : null,
      location: json["location"] as String?,
      createdBy: json["created_by"] as String?,
      type: json["type"] as String?,
      benefits: json["benefits"] as String?,
      bannerUrl: json["banner_url"] as String?,
      category: json["category"] as String?,
      upvoteCount: json["upvote_count"] as int?,
      documentationUrl: json["documentation_url"] as String?,
      galleryUrls: (json["gallery_urls"] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      timeline: (json["timeline"] as List<dynamic>?)
          ?.map((e) => TimelineEntry.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  factory EventModel.fromMap(Map<dynamic, dynamic> map) {
    return EventModel(
      id: map["id"] as String?,
      title: map["title"] as String?,
      description: map["description"] as String?,
      status: map["status"] as String?,
      startDate: map["start_date"] != null
          ? DateTime.parse(map["start_date"] as String)
          : null,
      endDate: map["end_date"] != null
          ? DateTime.parse(map["end_date"] as String)
          : null,
      location: map["location"] as String?,
      createdBy: map["created_by"] as String?,
      type: map["type"] as String?,
      benefits: map["benefits"] as String?,
      bannerUrl: map["banner_url"] as String?,
      category: map["category"] as String?,
      upvoteCount: map["upvote_count"] as int?,
      documentationUrl: map["documentation_url"] as String?,
      galleryUrls: (map["gallery_urls"] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      timeline: (map["timeline"] as List<dynamic>?)
          ?.map((e) => TimelineEntry.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  static List<EventModel> fromMapList(List<dynamic> mapList) {
    return mapList.map((map) => EventModel.fromMap(map)).toList();
  }

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "title": title,
      "description": description,
      "status": status,
      "start_date": startDate?.toIso8601String(),
      "end_date": endDate?.toIso8601String(),
      "location": location,
      "created_by": createdBy,
      "type": type,
      "benefits": benefits,
      "banner_url": bannerUrl,
      "category": category,
      "upvote_count": upvoteCount,
      "documentation_url": documentationUrl,
      "gallery_urls": galleryUrls,
      "timeline": timeline?.map((e) => e.toMap()).toList(),
    };
  }

  static List<EventModel> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((json) => EventModel.fromJson(json)).toList();
  }

  static List<Map<String, dynamic>> toMapList(List<EventModel> eventList) {
    return eventList.map((event) => event.toMap()).toList();
  }
}
