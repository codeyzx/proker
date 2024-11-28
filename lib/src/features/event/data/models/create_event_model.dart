import 'package:proker/src/features/event/domain/entities/event_entity.dart';

class CreateEventModel extends EventEntity {
  CreateEventModel({
    String? title,
    String? description,
    String? status,
    DateTime? startDate,
    String? location,
    String? createdBy,
    String? type,
    String? benefits,
    String? bannerUrl,
    String? category,
    int? upvoteCount,
    super.documentationUrl,
    super.galleryUrls,
    super.timeline,
  }) : super(
          title: title ?? '',
          description: description ?? '',
          status: status ?? '',
          startDate: startDate ?? DateTime.now(),
          location: location ?? '',
          createdBy: createdBy ?? '',
          type: type ?? '',
          benefits: benefits ?? '',
          bannerUrl: bannerUrl ?? '',
          category: category ?? '',
          upvoteCount: upvoteCount ?? 0,
        );

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

  CreateEventModel copyWith({
    String? title,
    String? description,
    String? status,
    DateTime? startDate,
    String? location,
    String? createdBy,
    String? type,
    String? benefits,
    String? bannerUrl,
    String? category,
    int? upvoteCount,
    String? documentationUrl,
    List<String>? galleryUrls,
    List<TimelineEntry>? timeline,
  }) {
    return CreateEventModel(
      title: title ?? this.title,
      description: description ?? this.description,
      status: status ?? this.status,
      startDate: startDate ?? this.startDate,
      location: location ?? this.location,
      createdBy: createdBy ?? this.createdBy,
      type: type ?? this.type,
      benefits: benefits ?? this.benefits,
      bannerUrl: bannerUrl ?? this.bannerUrl,
      category: category ?? this.category,
      upvoteCount: upvoteCount ?? this.upvoteCount,
      documentationUrl: documentationUrl ?? this.documentationUrl,
      galleryUrls: galleryUrls ?? this.galleryUrls,
      timeline: timeline ?? this.timeline,
    );
  }
}
