import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class UserApi {
  Future<bool> createNewUser(String email, String password) async {
    Map<String, String> bodyRequest = {
      'email': email,
      'password': password,
    };
    Map<String, String> headers = {
      'Content-Type': 'application/json',
    };
    print(bodyRequest);
    print("${dotenv.env['BASE_URL']}/api/users");
    var response = await http.post(
      Uri.parse("${dotenv.env['BASE_URL']}/api/users"),
      body: convert.jsonEncode(bodyRequest),
      headers: headers,
    );
    if (response.statusCode == 200) {
      print(response.statusCode);
      return true;
    } else {
      print(response.body);
      return false;
    }
  }

  Future<bool> signIn(String email, String password) async {
    Map<String, String> bodyRequest = {
      'email': email,
      'password': password,
    };
    Map<String, String> headers = {
      'Content-Type': 'application/json',
    };
    print(bodyRequest);
    print("${dotenv.env['BASE_URL']}/api/users/login");
    var response = await http.post(
      Uri.parse("${dotenv.env['BASE_URL']}/api/users/login"),
      body: convert.jsonEncode(bodyRequest),
      headers: headers,
    );
    if (response.statusCode == 200) {
      print(response.body);
      var result = convert.jsonDecode(response.body);
      print("result " + result['token']);
      var box = await Hive.openBox('box');
      box.put('jwt', result['token']);
      print(box.get('jwt'));
      return true;
    } else {
      print(response.body);
      return false;
    }
  }
}
