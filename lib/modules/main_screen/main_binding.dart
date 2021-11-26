import 'package:get/get.dart';
import 'package:happy_care/data/repositories/doctor_repository.dart';
import 'package:happy_care/data/repositories/spec_repository.dart';
import 'package:happy_care/data/repositories/user_repository.dart';
import 'package:happy_care/data/socket/socket_io_service.dart';
import 'package:happy_care/modules/chat/chat_controller.dart';
import 'package:happy_care/modules/home/home_controller.dart';
import 'package:happy_care/modules/main_screen/controller/doctor_controller.dart';
import 'package:happy_care/modules/main_screen/controller/main_controller.dart';
import 'package:happy_care/modules/main_screen/controller/spec_controller.dart';
import 'package:happy_care/modules/prescription/prescription_controller.dart';
import 'package:happy_care/modules/user/user_controller.dart';


class MainBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SocketIOService?>(() => SocketIOService());
    Get.lazyPut<UserRepository?>(() => UserRepository(ioService: Get.find()));
    Get.lazyPut<SpecializationRepository?>(() => SpecializationRepository());
    Get.lazyPut<DoctorRepository?>(() => DoctorRepository());
    Get.lazyPut(() => SpecController(specRepo: Get.find()));
    Get.lazyPut(() =>
        DoctorController(doctorRepository: Get.find(), ioService: Get.find()));
    Get.lazyPut(() => MainController(userRepository: Get.find()));
    Get.lazyPut(() => HomeController());
    Get.lazyPut(() => ChatController(socketService: Get.find()));
    Get.lazyPut(() => PrescriptionController());
    Get.lazyPut(() => UserController(userRepository: Get.find()));
  }
}
