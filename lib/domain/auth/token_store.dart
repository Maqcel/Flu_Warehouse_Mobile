abstract class TokenStore {
  Future<void> initTokenStore();

  Future<void> saveToken(String token);

  Future<String?> getToken();

  Future<void> clearToken();
}
