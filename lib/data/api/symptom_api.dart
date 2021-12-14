import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart';

class SymptomApi {
  final Client http;

  SymptomApi(this.http);

  Future<String> getAllSymptom({required String token}) async {
    final header = {"Authorization": "Bearer $token"};
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
}
