abstract class IUserRepository {
  Future<bool> createNewUser(String username, String password);
}
