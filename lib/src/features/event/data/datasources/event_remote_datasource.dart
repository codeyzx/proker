import 'package:injectable/injectable.dart';
import 'package:proker/src/core/api/api_url.dart';
import 'package:proker/src/core/errors/exceptions.dart';
import 'package:proker/src/core/utils/logger.dart';
import 'package:proker/src/features/event/data/models/models.dart';
import 'package:proker/src/features/event/domain/entities/event_entity.dart';

@factoryMethod
sealed class EventRemoteDataSource {
  Future<List<EventModel>> fetchEvent();
  Future<void> createEvent(EventEntity model);
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

      return response.docs
          .map((e) => EventModel.fromJson(e.data().toJson()))
          .toList();
    } catch (e) {
      logger.e(e);
      throw ServerException();
    }
  }

  @override
  Future<void> createEvent(EventEntity model) async {
    try {
      await ApiUrl.events.add(model);
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
