abstract class UserService {
  Future<void> saveUser(String userId);

  Future<String?> getUser();

  Future<void> clearUser();
}
