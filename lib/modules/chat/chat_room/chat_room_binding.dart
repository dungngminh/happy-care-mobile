import 'package:get/get.dart';
import 'package:happy_care/data/socket/socket_io_service.dart';
import 'package:happy_care/modules/chat/chat_room/chat_room_controller.dart';

class ChatRoomBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SocketIOService?>(() => Get.find());
    Get.lazyPut(() => ChatRoomController(ioService: Get.find()));
  }
}
