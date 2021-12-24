import 'dart:async';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart';

class DrugApi {
  final Client http;

  DrugApi(this.http);

  Future<String> getAllDrug() async {
    var response = await http
        .get(
      // Uri.parse("${dotenv.env['BASE_URL']}$path"),
      Uri.parse("${dotenv.env['BASE_URL']}/api/drugs"),
    )
        .timeout(Duration(minutes: 1), onTimeout: () {
      throw TimeoutException("Time out exception");
    });
    if (response.statusCode == 200) {
      print("=======GET_DRUG======\n" + response.body);
      return response.body;
    } else {
      throw Exception();
    }
  }

}
