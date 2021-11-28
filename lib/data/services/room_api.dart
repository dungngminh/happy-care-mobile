import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart';
import 'dart:convert' as convert;
class RoomApi {
  final Client http;

  RoomApi(this.http);

  Future<String> checkRoomIfExist({
    required String token,
    required String userId,
    required String doctorId,
  }) async {
    Map<String, String> body = {
      'memberId': userId,
      'doctorId': doctorId,
    };
    Map<String, String> headers = {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json',
    };

    var response = await http.post(
        // Uri.parse("${dotenv.env['BASE_URL']}/api/rooms/verify-room"),
        Uri.parse("${dotenv.env['DEV_URL']}/api/rooms/verify-room"),
        body: convert.jsonEncode(body),
        headers: headers);

    if (response.statusCode == 200) {
      print("============CHECK_ROOM_API_RESPONSE===========");
      print(response.body);
    } else {
      print("============ERROR_CHECK_ROOM_API_RESPONSE===========");
      print(response.body);
    }
    return response.body;
  }
}
