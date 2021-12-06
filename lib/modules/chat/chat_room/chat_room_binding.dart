import 'package:get/get.dart';
import 'package:happy_care/data/repositories/mess_repository.dart';
import 'package:happy_care/data/api/mess_api.dart';
import 'package:happy_care/data/services/my_cloudinary_service.dart';
import 'package:happy_care/data/services/socket_io_service.dart';
import 'package:happy_care/modules/chat/chat_room/chat_room_controller.dart';
import 'package:http/http.dart';

class ChatRoomBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SocketIOService?>(() => Get.find());
    Get.lazyPut<MessApi?>(() => MessApi(Client()));
    Get.lazyPut<MessRepository?>(() => MessRepository(messApi: Get.find()));
    Get.lazyPut(
      () => ChatRoomController(
        ioService: Get.find(),
        messRepo: Get.find(),
      
      ),
    );
  }
}
