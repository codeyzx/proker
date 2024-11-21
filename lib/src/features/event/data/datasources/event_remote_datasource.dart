import 'package:injectable/injectable.dart';
import 'package:proker/src/core/api/api_url.dart';
import 'package:proker/src/core/errors/exceptions.dart';
import 'package:proker/src/core/utils/logger.dart';
import 'package:proker/src/features/event/data/models/models.dart';

@factoryMethod
sealed class EventRemoteDataSource {
  Future<List<EventModel>> fetchEvent();
  Future<void> createEvent(CreateEventModel model);
  Future<void> updateEvent(UpdateEventModel model);
  Future<void> deleteEvent(DeleteEventModel model);
}

@LazySingleton(as: EventRemoteDataSource)
class EventRemoteDataSourceImpl implements EventRemoteDataSource {
  const EventRemoteDataSourceImpl();

  @override
  Future<List<EventModel>> fetchEvent() => fetchEventFromUrl("");

  Future<List<EventModel>> fetchEventFromUrl(String url) async {
    try {
      final response = await ApiUrl.events.get();

      return EventModel.fromJsonList(response.docs
          .map((e) => {
                "id": e.id,
                "title": e.data()["title"],
                "description": e.data()["description"],
                "status": e.data()["status"],
                "startDate": e.data()["startDate"],
                "endDate": e.data()["endDate"],
                "location": e.data()["location"],
                "createdBy": e.data()["createdBy"],
                "type": e.data()["type"],
                "benefits": e.data()["benefits"],
                "bannerUrl": e.data()["bannerUrl"],
                "category": e.data()["category"],
                "upvoteCount": e.data()["upvoteCount"],
                "documentationUrl": e.data()["documentationUrl"],
                "galleryUrls": e.data()["galleryUrls"],
                "timeline": e.data()["timeline"],
              })
          .toList());
    } catch (e) {
      logger.e(e);
      throw ServerException();
    }
  }

  @override
  Future<void> createEvent(CreateEventModel model) async {
    try {
      await ApiUrl.events.add(model.toMap());
      return;
    } catch (e) {
      logger.e(e);
      throw ServerException();
    }
  }

  @override
  Future<void> deleteEvent(DeleteEventModel model) async {
    try {
      await ApiUrl.events.doc(model.id).delete();
      return;
    } catch (e) {
      logger.e(e);
      throw ServerException();
    }
  }

  @override
  Future<void> updateEvent(UpdateEventModel model) async {
    try {
      await ApiUrl.events.doc(model.id).update(model.toMap());
      return;
    } catch (e) {
      logger.e(e);
      throw ServerException();
    }
  }
}
