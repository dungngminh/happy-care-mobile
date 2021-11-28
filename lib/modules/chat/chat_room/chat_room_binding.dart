import 'package:get/get.dart';
import 'package:happy_care/modules/chat/chat_room/chat_room_controller.dart';

class ChatRoomBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ChatRoomController());
  }
}
