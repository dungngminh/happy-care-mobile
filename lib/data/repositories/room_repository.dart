import 'package:happy_care/core/utils/shared_pref.dart';
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
}
