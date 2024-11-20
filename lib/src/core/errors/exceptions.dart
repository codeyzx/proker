class ServerException implements Exception {}

class CacheException implements Exception {}

class AuthException implements Exception {}

class EmptyException implements Exception {}

class DuplicateEmailException implements Exception {}

class CustomFirebaseAuthException implements Exception {
  final String message;
  CustomFirebaseAuthException(this.message);
}
