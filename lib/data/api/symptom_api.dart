import 'dart:async';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart';

class SymptomApi {
  final Client http;

  SymptomApi(this.http);

  Future<String> getAllSymptom({required String token}) async {
    var response = await http
        .get(Uri.parse("${dotenv.env['BASE_URL']}/api/symptom-keyword"));

    if (response.statusCode == 200) {
      print("===========GET_SYMPTOM==========\n${response.body}");
      return response.body;
    } else {
      print("===========GET_SYMPTOM_ERROR============");
      throw Exception();
    }
  }

  Future<String> getSpecBySymptom(String token,
      {required String symptomsKeyword}) async {
    Map<String, String> header = {
      "Authorization": "Bearer $token",
    };

    var response = await http
        .get(
      Uri.parse(
          "${dotenv.env['BASE_URL']}/api/users/specialization/symptom-keyword?keys=$symptomsKeyword"),
      headers: header,
    )
        .timeout(Duration(minutes: 30), onTimeout: () {
      throw TimeoutException("Time out exception");
    });
    if (response.statusCode == 200) {
      print("=======GET_SPEC_BY_SYMPTOM======\n" + response.body);
      return response.body;
    } else {
      throw Exception();
    }
  }
}
