import 'dart:async';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart';
import 'dart:convert' as convert;

class RoomApi {
  final Client http;

  RoomApi(this.http);

  Future<String> checkRoomIfExist({
    required String token,
    required String memberId,
    required String doctorId,
  }) async {
    Map<String, String> body = {
      'memberId': memberId,
      'doctorId': doctorId,
    };
    Map<String, String> headers = {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json',
    };

    var response = await http
        .post(
            // Uri.parse("${dotenv.env['BASE_URL']}/api/rooms/verify-room"),
            Uri.parse("${dotenv.env['BASE_URL']}/api/rooms/verify-room"),
            body: convert.jsonEncode(body),
            headers: headers)
        .timeout(Duration(minutes: 1), onTimeout: () {
      throw TimeoutException("Time out exception");
    });

    if (response.statusCode == 200) {
      print("============CHECK_ROOM_API_RESPONSE===========");
      print(response.body);
    } else {
      print("============ERROR_CHECK_ROOM_API_RESPONSE===========");
      print(response.body);
    }
    return response.body;
  }

  Future<String> getMyRoom(String token) async {
    Map<String, String> headers = {
      'Authorization': 'Bearer $token',
    };

    var response = await http
        .get(
      // Uri.parse("${dotenv.env['BASE_URL']}/api/rooms/me"),
      Uri.parse("${dotenv.env['BASE_URL']}/api/rooms/me"),
      headers: headers,
    )
        .timeout(Duration(minutes: 2), onTimeout: () {
      throw TimeoutException("Time out exception");
    });

    if (response.statusCode == 200) {
      print("============GET_ROOM_API_RESPONSE===========");
      print(response.body);
    } else {
      print("============ERROR_GET_ROOM_API_RESPONSE===========");
      print(response.body);
    }
    return response.body;
  }
}
