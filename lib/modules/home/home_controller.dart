import 'package:get/get.dart';
import 'package:happy_care/data/models/news_detail.dart';
import 'package:happy_care/data/repositories/news_repository.dart';

enum NewsStatus { loading, error, done }

class HomeController extends GetxController {
  var userStatus = 0.obs;
  final NewsReposity? newsReposity;
  final listNews = RxList<NewsDetail>([]);
  final newsStatus = NewsStatus.done.obs;

  HomeController({this.newsReposity});

  @override
  Future<void> onInit() async {
    super.onInit();
    await loadAllNews();
  }

  Future<void> loadAllNews() async {
    newsStatus(NewsStatus.loading);
    await newsReposity!.getAllNews().then((news) {
      listNews(news);
      newsStatus(NewsStatus.done);
    }).onError((error, stackTrace) {
      newsStatus(NewsStatus.error);
    });
  }

  ///Action to hide or change status
  onTapAction(bool isSick) {
    isSick ? userStatus(2) : userStatus(1);
  }
}
