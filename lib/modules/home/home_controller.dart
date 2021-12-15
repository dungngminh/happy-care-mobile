import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:happy_care/core/utils/shared_pref.dart';
import 'package:happy_care/data/models/news_detail.dart';
import 'package:happy_care/data/models/symptom.dart';
import 'package:happy_care/data/repositories/news_repository.dart';
import 'package:happy_care/data/repositories/symptom_repository.dart';

enum NewsStatus { loading, error, done }
enum SymptomStatus { loading, error, done }
enum UserTodayStatus { loading, error, done }

class HomeController extends GetxController {
  var userStatus = 0.obs;
  final NewsReposity? newsReposity;
  final SymptomRepository? symptomRepository;
  final ScrollController scrollController = ScrollController();
  final listNews = RxList<NewsDetail>([]);
  final listSymptom = RxList<Symptom>([]);
  final listChoice = RxList<bool>([]);
  final listMax = RxList<String>([]);
  int lap = 10;
  final newsStatus = NewsStatus.done.obs;
  final symptomStatus = SymptomStatus.done.obs;
  final userTodayStatus = UserTodayStatus.done.obs;
  final isMoreLoading = false.obs;

  HomeController({this.newsReposity, this.symptomRepository});

  @override
  Future<void> onInit() async {
    super.onInit();
    await loadAllNews();
    await loadAllSymtom();
    scrollController.addListener(() async {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        await getMoreNews();
      }
    });
    userTodayStatus(UserTodayStatus.loading);
    String? status = await SharedPrefUtils.getStringKey("status");

    if (status != null) {
      var date = DateTime.parse(status.split("--")[0]);
      if (DateTime.now().subtract(Duration(minutes: 30)).compareTo(date) > 0) {
        await SharedPrefUtils.removeStringKey("status");
      } else {
        userStatus(int.parse(status.split("--")[1]));
      }
    }
    userTodayStatus(UserTodayStatus.done);
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

  Future<void> loadAllSymtom() async {
    symptomStatus(SymptomStatus.loading);
    await symptomRepository!.getAllSymptom().then((value) async {
      listSymptom(value);
      symptomStatus(SymptomStatus.done);
      listChoice(List<bool>.filled(listSymptom.length, false, growable: false));
    }).onError((error, stackTrace) {
      symptomStatus(SymptomStatus.error);
    });
  }

  ///Action to hide or change status
  onTapAction(bool isSick) async {
    isSick
        ? {
            userStatus(2),
            await SharedPrefUtils.setStringKey(
                'status', DateTime.now().toLocal().toString() + "--2")
          }
        : {
            userStatus(1),
            await SharedPrefUtils.setStringKey(
                'status', DateTime.now().toLocal().toString() + "--1")
          };
  }

  ///Get more news
  Future<void> getMoreNews() async {
    isMoreLoading(true);
    await newsReposity!.getAllNews(start: lap).then((news) {
      listNews.addAll(news);
      isMoreLoading(false);
    }).onError((error, stackTrace) {
      isMoreLoading(false);
    });
    lap += 10;
  }

  void deleteAllChoices() {
    listChoice(List<bool>.filled(listSymptom.length, false, growable: false));
    listMax.clear();
  }

  findingSpecBySymptom() {}
}
