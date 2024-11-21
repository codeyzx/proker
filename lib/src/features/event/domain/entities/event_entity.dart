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
