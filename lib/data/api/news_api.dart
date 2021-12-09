import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart';

class NewsApi {
  final Client http;

  NewsApi(this.http);

  Future<String> getAllNews() async {
    var response = await http
        .get(Uri.parse("${dotenv.env['BASE_URL']}/api/news"))
        .timeout(Duration(minutes: 1));
    if (response.statusCode == 200) {
      print("==================GET_ALLNEW_SUCCESS===============");
      return response.body;
    } else {
      print("==================GET_ALLNEW_FAILED===============");
      throw Exception();
    }
  }
}
