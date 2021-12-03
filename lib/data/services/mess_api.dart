import 'dart:async';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart';

class MessApi {
  final Client http;

  MessApi(this.http);

  Future<String?> getMessageHistory(
      {required String token,
      required String roomId,
      int start = 0,
      int limit = 10}) async {
    Map<String, String> headers = {
      'Authorization': 'Bearer $token',
    };
    print(
        "${dotenv.env['DEV_URL']}/api/messages/$roomId?start=$start&limit=$limit");
    var response = await http
        .get(
            // Uri.parse("${dotenv.env['BASE_URL']}/api/rooms/verify-room"),
            Uri.parse(
                "${dotenv.env['DEV_URL']}/api/messages/$roomId?start=$start&limit=$limit"),
            headers: headers)
        .timeout(Duration(minutes: 1), onTimeout: () {
      throw TimeoutException("Time out exception");
    });
    if (response.statusCode == 200) {
      print(
          "==================GET_MESS_HISTORY_RESPONSE=====================\n");
      print(response.body);
      return response.body;
    } else {
      print(
          "==================GET_MESS_HISTORY_RESPONSE_ERROR=====================\n");
      print(response.body);
    }
  }
}
