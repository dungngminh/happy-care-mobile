import 'package:happy_care/data/models/specialization.dart';
import 'package:happy_care/data/services/spec_api.dart';
import 'dart:convert' as convert;

class SpecializationRepository {
  final SpecApi? specApi;

  SpecializationRepository({this.specApi});


  Future<List<Specialization>> getAllSpecAvaliable() async {
    try {
      var response = await specApi!.getAllSpecAvailable();
      var converted = convert.jsonDecode(response);
      Iterable list = converted['data']['specializations'];
      return list.map((element) => Specialization.fromJson(element)).toList();
    } catch (_) {
      throw Exception(_);
    }
  }
}
