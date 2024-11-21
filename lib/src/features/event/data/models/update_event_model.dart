import 'package:proker/src/features/event/domain/entities/event_entity.dart';

class UpdateEventModel extends EventEntity {
  UpdateEventModel({
    String? id,
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
          id: id ?? '',
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
}
