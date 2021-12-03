import 'package:happy_care/core/utils/shared_pref.dart';
import 'package:happy_care/data/models/chat_mess.dart';
import 'package:happy_care/data/services/mess_api.dart';
import 'dart:convert' as convert;

class MessRepository {
  final MessApi? messApi;

  MessRepository({this.messApi});

  Future<List<ChatMess>> getMessageHistory(
      {required String roomId, int start = 0, int limit = 10}) async {
    try {
      String token = await SharedPrefUtils.getStringKey('token');
      String? response = await messApi!.getMessageHistory(
        token: token,
        roomId: roomId,
        start: start,
        limit: limit,
      );
      var converted = convert.jsonDecode(response!);
      Iterable listMess = converted['data'];
      print("Converted mess chat oke call :)");
      return listMess.map((mess) => ChatMess.fromMap(mess)).toList();
    } catch (e) {
      throw Exception();
    }
  }
}
