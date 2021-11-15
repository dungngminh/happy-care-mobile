import 'package:get/get.dart';
import 'package:happy_care/data/repositories/user_repository.dart';
import 'package:happy_care/modules/chat/chat_controller.dart';
import 'package:happy_care/modules/home/home_controller.dart';
import 'package:happy_care/modules/main_screen/main_controller.dart';
import 'package:happy_care/modules/prescription/prescription_controller.dart';
// import 'package:happy_care/modules/user/user_controller.dart';

class MainBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<UserRepository?>(() => UserRepository());
    Get.lazyPut(() => MainController());
    Get.lazyPut(() => HomeController());
    Get.lazyPut(() => ChatController());
    Get.lazyPut(() => PrescriptionController());
    // Get.lazyPut(() => UserController(userRepository: Get.find()));
  }
}
