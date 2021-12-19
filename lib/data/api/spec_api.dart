import 'dart:async';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart';

class SpecApi {
  final Client http;

  SpecApi(this.http);

  Future<String> getAllSpecAvailable() async {
    var response = await http
        .get(
      // Uri.parse("${dotenv.env['BASE_URL']}/api/users/login"),
      Uri.parse("${dotenv.env['BASE_URL']}/api/admin/specialization"),
    )
        .timeout(Duration(minutes: 1), onTimeout: () {
      throw TimeoutException("Time out exception");
    });
    if (response.statusCode == 200) {
      print("=======GET_SPEC======\n" + response.body);
      return response.body;
    } else {
      throw Exception();
    }
  }

  
}
