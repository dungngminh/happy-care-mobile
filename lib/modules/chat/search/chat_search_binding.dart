import 'package:get/get.dart';
import 'package:happy_care/modules/chat/search/chat_search_controller.dart';

class ChatSearchBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ChatSearchController());
  }
}
