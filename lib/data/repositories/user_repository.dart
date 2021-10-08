import 'package:happy_care/data/services/user_api.dart';

class UserRepository {
  Future<bool> createNewUser(
      {required String email, required String password}) {
    return UserApi().createNewUser(email, password);
  }

  Future<bool> signIn({required String email, required String password}) {
    return UserApi().signIn(email, password);
  }
}
