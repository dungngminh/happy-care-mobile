import 'package:happy_care/core/utils/shared_pref.dart';
import 'package:happy_care/data/api/symptom_api.dart';
import 'package:happy_care/data/models/specialization.dart';
import 'package:happy_care/data/models/symptom.dart';
import 'dart:convert' as convert;

class SymptomRepository {
  final SymptomApi? symptomApi;

  SymptomRepository({this.symptomApi});

  Future<List<Symptom>> getAllSymptom() async {
    try {
      String token = await SharedPrefUtils.getStringKey("token");
      String response = await symptomApi!.getAllSymptom(token: token);
      var converted = convert.jsonDecode(response);
      Iterable list = converted["data"]["keywords"];
      return list.map((data) => Symptom.fromJson(data)).toList();
    } catch (_) {
      throw Exception("From getAllSymptom");
    }
  }

  Future<List<Specialization?>> getSpecBySymptom(String symptomsKeyword) async {
    try {
      print(symptomsKeyword);
      String token = await SharedPrefUtils.getStringKey('token');
      var response = await symptomApi!
          .getSpecBySymptom(token, symptomsKeyword: symptomsKeyword);
      var converted = convert.jsonDecode(response);
      Iterable list = converted['data']['specializations'];
      return list.map((element) => Specialization.fromJson(element)).toList();
    } catch (_) {
      throw Exception();
    }
  }
}
