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
      startDate: json["startDate"] != null
          ? DateTime.parse(json["startDate"] as String)
          : null,
      endDate: json["endDate"] != null
          ? DateTime.parse(json["endDate"] as String)
          : null,
      location: json["location"] as String?,
      createdBy: json["createdBy"] as String?,
      type: json["type"] as String?,
      benefits: json["benefits"] as String?,
      bannerUrl: json["bannerUrl"] as String?,
      category: json["category"] as String?,
      upvoteCount: json["upvoteCount"] as int?,
      documentationUrl: json["documentationUrl"] as String?,
      galleryUrls: (json["galleryUrls"] as List<dynamic>?)
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
      startDate: map["startDate"] != null
          ? DateTime.parse(map["startDate"] as String)
          : null,
      endDate: map["endDate"] != null
          ? DateTime.parse(map["endDate"] as String)
          : null,
      location: map["location"] as String?,
      createdBy: map["createdBy"] as String?,
      type: map["type"] as String?,
      benefits: map["benefits"] as String?,
      bannerUrl: map["bannerUrl"] as String?,
      category: map["category"] as String?,
      upvoteCount: map["upvoteCount"] as int?,
      documentationUrl: map["documentationUrl"] as String?,
      galleryUrls: (map["galleryUrls"] as List<dynamic>?)
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
      "startDate": startDate,
      "location": location,
      "createdBy": createdBy,
      "type": type,
      "benefits": benefits,
      "bannerUrl": bannerUrl,
      "category": category,
      "upvoteCount": upvoteCount,
      "documentationUrl": documentationUrl,
      "galleryUrls": galleryUrls,
      "timeline": timeline,
    };
  }

  static List<EventModel> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((json) => EventModel.fromJson(json)).toList();
  }

  static List<Map<String, dynamic>> toMapList(List<EventModel> eventList) {
    return eventList.map((event) => event.toMap()).toList();
  }
}
