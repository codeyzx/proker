import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:injectable/injectable.dart';
import 'package:proker/src/core/cache/local_storage.dart';

@module
abstract class RegisterModule {
  @lazySingleton
  FlutterSecureStorage get flutterSecureStorage;

  @lazySingleton
  IOSOptions get iosOptions => const IOSOptions();

  @lazySingleton
  AndroidOptions get androidOptions => const AndroidOptions();

  @lazySingleton
  LinuxOptions get linuxOptions => const LinuxOptions();

  @lazySingleton
  WindowsOptions get windowsOptions => const WindowsOptions();

  @lazySingleton
  WebOptions get webOptions => const WebOptions();

  @lazySingleton
  MacOsOptions get macOsOptions => const MacOsOptions();
}

@injectable
class SecureLocalStorage implements LocalStorage {
  final FlutterSecureStorage _storage;
  const SecureLocalStorage(this._storage);

  @override
  Future<String> load({required String key, String? boxName}) async {
    final result = await _storage.read(key: key);

    return result ?? "";
  }

  @override
  Future<void> save({
    required String key,
    required value,
    String? boxName,
  }) async {
    final result = await _storage.write(key: key, value: value);

    return result;
  }

  @override
  Future<void> delete({required String key, String? boxName}) async {
    await _storage.delete(key: key);

    return;
  }
}
