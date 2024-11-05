import 'package:proker/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  AuthRepositoryImpl();

  @override
  Future<void> login(String username, String password) async {}

  @override
  Future<String> getFCMToken() {
    // TODO: implement getFCMToken
    throw UnimplementedError();
  }

  @override
  Future<String> getFCMTokenFromFirebase() {
    // TODO: implement getFCMTokenFromFirebase
    throw UnimplementedError();
  }

  @override
  Future<String> getRole() {
    // TODO: implement getRole
    throw UnimplementedError();
  }

  @override
  Future<String> getToken() {
    // TODO: implement getToken
    throw UnimplementedError();
  }

  @override
  Future<String> getUsername() {
    // TODO: implement getUsername
    throw UnimplementedError();
  }

  @override
  Future<bool> hasLoggedInAnotherDevice(String username, String password) {
    // TODO: implement hasLoggedInAnotherDevice
    throw UnimplementedError();
  }

  @override
  Future<bool> isTokenValid() {
    // TODO: implement isTokenValid
    throw UnimplementedError();
  }

  @override
  Future<void> logout() {
    // TODO: implement logout
    throw UnimplementedError();
  }

  @override
  Future<void> saveFCMToken(String fcmToken) {
    // TODO: implement saveFCMToken
    throw UnimplementedError();
  }
}
