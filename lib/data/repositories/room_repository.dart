import 'package:happy_care/core/utils/shared_pref.dart';
import 'package:happy_care/data/models/room_chat/room_chat.dart';
import 'package:happy_care/data/api/room_api.dart';
import 'dart:convert' as convert;

class RoomRepository {
  final RoomApi? roomApi;

  RoomRepository({this.roomApi});

  Future<String?> checkRoomIfExist(
      {required String memberId, required String doctorId}) async {
    String token = await SharedPrefUtils.getStringKey('token');
    String response = await roomApi!
        .checkRoomIfExist(token: token, memberId: memberId, doctorId: doctorId);
    var converted = convert.jsonDecode(response);
    if (converted["success"] == true) {
      return converted["data"]["roomId"];
    } else {
      return null;
    }
  }

  Future<List<RoomChat?>> getMyRoom() async {
    String token = await SharedPrefUtils.getStringKey('token');
    String response = await roomApi!.getMyRoom(token);
    var converted = convert.jsonDecode(response);
    Iterable listRoom = converted['data']['rooms'];
    return listRoom.map((room) => RoomChat.fromJson(room)).toList();
  }
}
