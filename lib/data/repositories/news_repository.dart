import 'package:happy_care/data/api/news_api.dart';
import 'package:happy_care/data/models/news_detail.dart';
import 'dart:convert' as convert;

class NewsReposity {
  final NewsApi? newsApi;

  NewsReposity({this.newsApi});

  Future<List<NewsDetail>> getAllNews({int start = 0, int limit = 10}) async {
    try {
      String response = await newsApi!.getAllNews(start: start, limit: limit);
      var converted = convert.jsonDecode(response);
      print("converted news oke");
      Iterable list = converted['data'];
      return list.map((data) => NewsDetail.fromJson(data)).toList();
    } catch (_) {
      throw Exception();
    }
  }
}
