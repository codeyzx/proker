abstract class AuthRepository {
  // Getters
  Future<String> getToken();
  Future<String> getUsername();
  Future<String> getRole();
  Future<String> getFCMToken();
  Future<String> getFCMTokenFromFirebase();
  Future<bool> isTokenValid();
  Future<bool> hasLoggedInAnotherDevice(String username, String password);

  // Actions
  Future<void> login(String username, String password);
  Future<void> logout();
  Future<void> saveFCMToken(String fcmToken);
}
