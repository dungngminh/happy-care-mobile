import 'package:happy_care/core/utils/shared_pref.dart';
import 'package:happy_care/data/models/user.dart';
import 'package:happy_care/data/services/doctor_api.dart';
import 'dart:convert' as convert;

class DoctorRepository {
  Future<List<User>> getDoctorMaybeBySpecId({String? specId}) async {
    try {
      String token = await SharedPrefUtils.getStringKey('token');
      String response =
          await DoctorApi().getDoctorMaybeBySpecId(token: token, specId: specId);
      var converted = convert.jsonDecode(response);
      Iterable listDoctor = converted['data']['doctors'];
      return listDoctor.map((data) => User.fromJson(data)).toList();
    } catch (e) {
      throw Exception(e);
    }
  }
}
