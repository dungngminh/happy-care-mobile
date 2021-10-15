import 'dart:convert' as convert;

import 'package:happy_care/core/utils/shared_pref.dart';
import 'package:happy_care/data/services/user_api.dart';

class UserRepository {
  Future<bool> createNewUser(
      {required String email, required String password}) async {
    try {
      String response = await UserApi().createNewUser(email, password);
      return true;
    } catch (_) {
      return false;
    }
  }

  Future<bool> signIn({required String email, required String password}) async {
    try {
      String response = await UserApi().signIn(email, password);
      var result = convert.jsonDecode(response);
      String token = result['token'];
      await SharedPrefUtils.setStringKey('token', token);
      return true;
    } catch (_) {
      print(_ as Exception);
      return false;
    }
  }

  Future<bool> signOut() async {
    try {
      await SharedPrefUtils.removeStringKey('token');
      return true;
    } catch (_) {
      return false;
    }
  }
}
