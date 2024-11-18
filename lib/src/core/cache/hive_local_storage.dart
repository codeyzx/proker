import 'package:hive_flutter/hive_flutter.dart';
import 'package:injectable/injectable.dart';

import 'package:proker/src/core/cache/local_storage.dart';

@singleton
class HiveLocalStorage implements LocalStorage {
  @override
  Future<dynamic> load({required String key, String? boxName}) async {
    await Hive.openBox(boxName!);
    final box = Hive.box(boxName);
    try {
      final result = await box.get(key);
      return result;
    } catch (_) {
      rethrow;
    } finally {
      box.close();
    }
  }

  @override
  Future<void> save({
    required String key,
    required dynamic value,
    String? boxName,
  }) async {
    await Hive.openBox(boxName!);
    final box = Hive.box(boxName);
    try {
      await box.put(key, value);

      return;
    } catch (_) {
      rethrow;
    } finally {
      box.close();
    }
  }

  @override
  Future<void> delete({required String key, String? boxName}) async {
    await Hive.openBox(boxName!);
    final box = Hive.box(boxName);
    try {
      await box.delete(key);
      return;
    } catch (_) {
      rethrow;
    } finally {
      box.close();
    }
  }
}
