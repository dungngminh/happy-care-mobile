import 'dart:async';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class UserApi {
  Future<String> createNewUser(String email, String password) async {
    Map<String, String> bodyRequest = {
      'email': email,
      'password': password,
    };
    Map<String, String> headers = {
      'Content-Type': 'application/json',
    };
    print(bodyRequest);
    print("${dotenv.env['DEV_URL']}/api/users");
    var response = await http.post(
      Uri.parse("${dotenv.env['DEV_URL']}/api/users"),
      body: convert.jsonEncode(bodyRequest),
      headers: headers,
    );
    if (response.statusCode == 200) {
      print(response.statusCode);
      return response.body;
    } else {
      print(response.body);
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
    print(body);
    print("${dotenv.env['DEV_URL']}/api/users/login");
    var response = await http
        .post(
      // Uri.parse("${dotenv.env['BASE_URL']}/api/users/login"),
      Uri.parse("${dotenv.env['DEV_URL']}/api/users/login"),

      body: convert.jsonEncode(body),
      headers: headers,
    )
        .timeout(Duration(minutes: 2), onTimeout: () {
      throw TimeoutException("Time out exception");
    });
    if (response.statusCode == 200) {
      print(response.statusCode);
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
    print(token);
    // print("${dotenv.env['BASE_URL']}/api/users/me");
    print("${dotenv.env['DEV_URL']}/api/users/me");
    var response = await http.get(
      // Uri.parse("${dotenv.env['BASE_URL']}/api/users/me"),
      Uri.parse("${dotenv.env['DEV_URL']}/api/users/me"),

      headers: headers,
    );
    print(response.statusCode);
    if (response.statusCode == 200) {
      print(response.body);
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
        .timeout(Duration(minutes: 2), onTimeout: () {
      throw TimeoutException("Time out exception");
    });
    if (response.statusCode == 200) {
      print(response.body);
      return true;
    } else {
      print(response.body);
      throw Exception("Cant sign out");
    }
  }

  // Future<String> updateUserInformation({
  //   required String token,
  //   String? fullName,
  //   String? phone,
  //   String? address,
  // }) async {
  //   Map<String, String> headers = {
  //     'Authorization':'Bearer $token',
  //   };

  // }
}
