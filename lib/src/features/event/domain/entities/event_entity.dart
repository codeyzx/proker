import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class EventEntity extends Equatable {
  final String? id;
  final String? title;
  final String? description;
  final String? status;
  final DateTime? startDate;
  final DateTime? endDate;
  final String? location;
  final String? createdBy;
  final String? type;
  final String? benefits;
  final String? bannerUrl;
  final String? category;
  final int? upvoteCount;
  final String? documentationUrl;
  final List<String>? galleryUrls;
  final List<TimelineEntry>? timeline;

  const EventEntity({
    this.id,
    this.title,
    this.description,
    this.status,
    this.startDate,
    this.endDate,
    this.location,
    this.createdBy,
    this.type,
    this.benefits,
    this.bannerUrl,
    this.category,
    this.upvoteCount,
    this.documentationUrl,
    this.galleryUrls,
    this.timeline,
  });

  factory EventEntity.fromJson(Map<String, dynamic> json) {
    return EventEntity(
      id: json["id"] as String?,
      title: json["title"] as String?,
      description: json["description"] as String?,
      status: json["status"] as String?,
      startDate: json["startDate"] != null
          ? (json["startDate"] is Timestamp
              ? (json["startDate"] as Timestamp).toDate()
              : DateTime.parse(json["startDate"].toString()))
          : null,
      endDate: json["endDate"] != null
          ? (json["endDate"] is Timestamp
              ? (json["endDate"] as Timestamp).toDate()
              : DateTime.parse(json["endDate"].toString()))
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

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "title": title,
      "description": description,
      "status": status,
      'startDate': startDate?.toIso8601String(),
      'endDate': endDate?.toIso8601String(),
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

  @override
  List<Object?> get props {
    return [
      id,
      title,
      description,
      status,
      startDate,
      endDate,
      location,
      createdBy,
      type,
      benefits,
      bannerUrl,
      category,
      upvoteCount,
      documentationUrl,
      galleryUrls,
      timeline,
    ];
  }
}

class TimelineEntry extends Equatable {
  final DateTime? createdAt;
  final String? status;

  const TimelineEntry({
    this.createdAt,
    this.status,
  });

  @override
  List<Object?> get props {
    return [
      createdAt,
      status,
    ];
  }

  factory TimelineEntry.fromJson(Map<String, dynamic> json) {
    return TimelineEntry(
      createdAt: DateTime.parse(json["created_at"] as String),
      status: json["status"] as String,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "created_at": createdAt,
      "status": status,
    };
  }
}
