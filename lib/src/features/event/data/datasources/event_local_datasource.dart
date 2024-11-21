import 'package:injectable/injectable.dart';
import 'package:proker/src/core/cache/hive_local_storage.dart';
import 'package:proker/src/core/errors/exceptions.dart';
import 'package:proker/src/core/utils/logger.dart';
import 'package:proker/src/features/event/data/models/get_event_model.dart';

sealed class EventLocalDataSource {
  Future<List<EventModel>> getAllEvent();
}

@LazySingleton(as: EventLocalDataSource)
class EventLocalDataSourceImpl implements EventLocalDataSource {
  final HiveLocalStorage _localStorage;
  const EventLocalDataSourceImpl(this._localStorage);

  @override
  Future<List<EventModel>> getAllEvent() => _getEventFromCache();

  Future<List<EventModel>> _getEventFromCache() async {
    try {
      final response = await _localStorage.load(
        key: "events",
        boxName: "cache",
      );

      if (response is! List) {
        throw CacheException();
      }

      return EventModel.fromMapList(response);
    } catch (e) {
      logger.e(e);
      throw CacheException();
    }
  }
}
