import 'package:get/get.dart';
import 'package:happy_care/data/repositories/user_repository.dart';
import 'package:happy_care/data/socket/socket_io_service.dart';
import 'package:happy_care/modules/chat/chat_controller.dart';
import 'package:happy_care/modules/home/home_controller.dart';
import 'package:happy_care/modules/main_screen/main_controller.dart';
import 'package:happy_care/modules/prescription/prescription_controller.dart';
import 'package:happy_care/modules/user/user_controller.dart';

class MainBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<UserRepository?>(() => UserRepository());
    Get.lazyPut<SocketIOService?>(() => SocketIOService());
    Get.lazyPut(() => MainController(userRepository: Get.find()));
    Get.lazyPut(() => HomeController());
    Get.lazyPut(() => ChatController(socketService: Get.find()));
    Get.lazyPut(() => PrescriptionController());
    Get.lazyPut(() => UserController(userRepository: Get.find()));
  }
}
