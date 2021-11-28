import 'dart:async';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart';
import 'dart:convert' as convert;

class UserApi {
  final Client http;

  UserApi(this.http);
  
  Future<String> createNewUser(String email, String password) async {
    Map<String, String> bodyRequest = {
      'email': email,
      'password': password,
    };
    Map<String, String> headers = {
      'Content-Type': 'application/json',
    };
    print("=============CREATE NEW USER BODY REQUEST==========\n$bodyRequest");
    var response = await http
        .post(
      Uri.parse("${dotenv.env['DEV_URL']}/api/users"),
      body: convert.jsonEncode(bodyRequest),
      headers: headers,
    )
        .timeout(Duration(minutes: 1), onTimeout: () {
      throw TimeoutException("Time out exception");
    });
    if (response.statusCode == 200) {
      print("=======CREATE_NEW_USER_RESPONSE======\n" + response.body);
      return response.body;
    } else {
      print("=======CREATE_NEW_USER_RESPONSE-ERROR======\n" + response.body);
      throw Exception("Cannot sign up");
    }
  }

  Future<String> signIn(String email, String password) async {
    Map<String, String> body = {
      'email': email,
      'password': password,
    };
    Map<String, String> headers = {
      'Content-Type': 'application/json',
    };
    print("=============SIGN IN BODY REQUEST==========\n$body");
    var response = await http
        .post(
      // Uri.parse("${dotenv.env['BASE_URL']}/api/users/login"),
      Uri.parse("${dotenv.env['DEV_URL']}/api/users/login"),

      body: convert.jsonEncode(body),
      headers: headers,
    )
        .timeout(Duration(minutes: 1), onTimeout: () {
      throw TimeoutException("Time out exception");
    });
    if (response.statusCode == 200) {
      print("=======SIGNIN_RESPONSE======\n" + response.body);
      return response.body;
    } else {
      print(response.body);
      throw Exception("Cannot sign in");
    }
  }

  Future<String> getDataInformation(String token) async {
    Map<String, String> headers = {
      'Authorization': 'Bearer $token',
    };
    // print("${dotenv.env['BASE_URL']}/api/users/me");
    var response = await http.get(
      // Uri.parse("${dotenv.env['BASE_URL']}/api/users/me"),
      Uri.parse("${dotenv.env['DEV_URL']}/api/users/me"),

      headers: headers,
    );
    print(response.statusCode);
    if (response.statusCode == 200) {
      print("=======GETDATA_USER======\n" + response.body);
      return response.body;
    } else {
      throw Exception("Cannot get user information");
    }
  }

  Future<bool> signOut({required String token}) async {
    Map<String, String> headers = {
      'Authorization': 'Bearer $token',
    };
    var response = await http
        .post(
      // Uri.parse("${dotenv.env['BASE_URL']}/api/users/login"),
      Uri.parse("${dotenv.env['DEV_URL']}/api/users/logout"),
      headers: headers,
    )
        .timeout(Duration(minutes: 1), onTimeout: () {
      throw TimeoutException("Time out exception");
    });
    if (response.statusCode == 200) {
      print("=======SIGNOUT_RESPONSE======\n" + response.body);
      return true;
    } else {
      print("=======SIGNOUT_RESPONSE_ERROR======\n" + response.body);
      throw Exception("Cant sign out");
    }
  }

  Future<bool> updateUserInformation(
      {required String token, required Map<String, dynamic> body}) async {
    Map<String, String> headers = {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json',
    };
    Map<String, dynamic> bodyy = {
      "profile": body,
    };

    print("=============UPDATE INFORMATION BODY REQUEST==========\n$bodyy");
    var response = await http
        .patch(
      // Uri.parse("${dotenv.env['BASE_URL']}/api/users/login"),
      Uri.parse("${dotenv.env['DEV_URL']}/api/users/me"),
      body: convert.jsonEncode(bodyy),
      headers: headers,
    )
        .timeout(Duration(minutes: 1), onTimeout: () {
      throw TimeoutException("Time out exception");
    });
    if (response.statusCode == 200) {
      print("=======UPDATE_INFORMATION======\n" + response.body);
      return true;
    } else {
      print("=======UPDATE_INFORMATION_ERROR======\n" + response.body);
      return false;
    }
  }
}
