import 'dart:convert' as convert;

import 'package:happy_care/core/utils/shared_pref.dart';
import 'package:happy_care/data/models/user.dart';
import 'package:happy_care/data/services/user_api.dart';

class UserRepository {
  final UserApi? userApi;
  UserRepository({this.userApi});

  Future<bool> createNewUser(
      {required String email, required String password}) async {
    try {
      await userApi!.createNewUser(email, password);
      return true;
    } catch (_) {
      print(_ as Exception);
      return false;
    }
  }

  Future<bool> signIn({required String email, required String password}) async {
    try {
      String response = await userApi!.signIn(email, password);
      var result = convert.jsonDecode(response);
      String token = result['data']['token'];
      await SharedPrefUtils.setStringKey('token', token);
      return true;
    } catch (_) {
      return false;
    }
  }

  Future<bool> signOut() async {
    String token = await SharedPrefUtils.getStringKey('token');
    await userApi!.signOut(token: token);
    print("Token is deleted ?${await SharedPrefUtils.removeStringKey('token')}");
    return true;
  }

  Future<User> getUserData() async {
    try {
      String token = await SharedPrefUtils.getStringKey('token');
      final response = await userApi!.getDataInformation(token);
      var result = convert.jsonDecode(response);
      print("===========CHECK CREATING USER============\n");
      print(User.fromJson(result['data']['user']));
      return User.fromJson(result['data']['user']);
    } catch (_) {
      await SharedPrefUtils.removeStringKey('token');
      throw Exception(_);
    }
  }

  Future<bool> updateInformation(
      {String? fullname,
      int? age,
      String? phone,
      String? address,
      String? avatar}) async {
    Map<String, dynamic> body = {
      "fullname": fullname,
      "age": age,
      "phone": phone,
      "address": address,
      "avatar": avatar,
    };

    String token = await SharedPrefUtils.getStringKey('token');
    return await userApi!.updateUserInformation(token: token, body: body);
  }
}
