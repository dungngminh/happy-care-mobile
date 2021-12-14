import 'package:get/get.dart';
import 'package:happy_care/modules/chat/search/search_controller.dart';

class SearchBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SearchController());
  }
}
