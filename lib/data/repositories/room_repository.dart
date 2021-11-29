import 'package:happy_care/core/utils/shared_pref.dart';
import 'package:happy_care/data/models/room_chat/room_chat.dart';
import 'package:happy_care/data/services/room_api.dart';
import 'dart:convert' as convert;

class RoomRepository {
  final RoomApi? roomApi;

  RoomRepository({this.roomApi});

  Future<bool> checkRoomIfExist(
      {required String userId, required String doctorId}) async {
    String token = await SharedPrefUtils.getStringKey('token');
    String response = await roomApi!
        .checkRoomIfExist(token: token, userId: userId, doctorId: doctorId);
    var converted = convert.jsonDecode(response);
    return converted["success"];
  }

  Future<List<RoomChat>?> getMyRoom() async {
    try {
      String token = await SharedPrefUtils.getStringKey('token');
      String response = await roomApi!.getMyRoom(token);
      var converted = convert.jsonDecode(response);
      Iterable listRoom = converted['data']['rooms'];
      return listRoom.map((room) => RoomChat.fromJson(room)).toList();
    } catch (_) {
      print(_.toString());
      return null;
    }
  }
}
