import 'dart:async';
import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart';

class PrescriptionApi {
  final Client http;

  PrescriptionApi(this.http);

  Future<String> getMyPrescription(String token) async {
    final header = {
      'Authorization': 'Bearer $token',
    };

    var response = await http
        .get(Uri.parse("${dotenv.env['BASE_URL']}/api/prescriptions/me"),
            headers: header)
        .timeout(Duration(minutes: 1), onTimeout: () {
      throw TimeoutException("Time out exception");
    });

    if (response.statusCode == 200) {
      print("=======GET_PRESCRIPTION======\n" + response.body);
      return response.body;
    } else {
      print("=======GET_PRESCRIPTION_ERROR======");
      throw Exception();
    }
  }

  Future<String> createNewPrescription(
      String token, Map<String, dynamic> body) async {
    final headers = {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json',
    };
    print(body);
    var response = await http
        .post(Uri.parse("${dotenv.env['BASE_URL']}/api/prescriptions"),
            headers: headers, body: jsonEncode(body))
        .timeout(Duration(minutes: 1), onTimeout: () {
      throw TimeoutException("Het gio roi thang l");
    });

    if (response.statusCode == 200) {
      print("Up don thuoc thanh cong");
      return response.body;
    } else {
      print("Up don thuoc deo thanh cong");
      print(response.body);
      throw Exception();
    }
  }

  Future<String> updatePrescription(
      String token, String id ,Map<String, dynamic> body) async {
    final headers = {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json',
    };
    print(body);
    var response = await http
        .patch(Uri.parse("${dotenv.env['BASE_URL']}/api/prescriptions/$id"),
            headers: headers, body: jsonEncode(body))
        .timeout(Duration(minutes: 1), onTimeout: () {
      throw TimeoutException("Het gio roi thang l");
    });

    if (response.statusCode == 200) {
      print("Update don thuoc thanh cong");
      return response.body;
    } else {
      print("Update don thuoc deo thanh cong");
      print(response.body);
      throw Exception();
    }
  }
}
