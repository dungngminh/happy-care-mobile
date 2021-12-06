import 'package:get/get.dart';
import 'package:happy_care/data/repositories/doctor_repository.dart';
import 'package:happy_care/data/repositories/room_repository.dart';
import 'package:happy_care/data/repositories/spec_repository.dart';
import 'package:happy_care/data/repositories/user_repository.dart';
import 'package:happy_care/data/api/doctor_api.dart';
import 'package:happy_care/data/api/room_api.dart';
import 'package:happy_care/data/api/spec_api.dart';
import 'package:happy_care/data/api/user_api.dart';
import 'package:happy_care/data/services/my_cloudinary_service.dart';
import 'package:happy_care/data/services/socket_io_service.dart';
import 'package:happy_care/modules/chat/chat_controller.dart';
import 'package:happy_care/modules/home/home_controller.dart';
import 'package:happy_care/modules/main_screen/controller/doctor_controller.dart';
import 'package:happy_care/modules/main_screen/controller/image_controller.dart';
import 'package:happy_care/modules/main_screen/controller/main_controller.dart';
import 'package:happy_care/modules/main_screen/controller/spec_controller.dart';
import 'package:happy_care/modules/prescription/prescription_controller.dart';
import 'package:happy_care/modules/user/user_controller.dart';
import 'package:http/http.dart';

class MainBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<UserApi?>(() => UserApi(Client()));
    Get.lazyPut<SpecApi?>(() => SpecApi(Client()));
    Get.lazyPut<DoctorApi?>(() => DoctorApi(Client()));
    Get.lazyPut<RoomApi?>(() => RoomApi(Client()));
    Get.lazyPut<SocketIOService?>(() => SocketIOService());
    Get.lazyPut<MyCloudinaryService?>(() => MyCloudinaryService());
    Get.lazyPut<UserRepository?>(() => UserRepository(userApi: Get.find()));
    Get.lazyPut<SpecializationRepository?>(
        () => SpecializationRepository(specApi: Get.find()));
    Get.lazyPut<DoctorRepository?>(
        () => DoctorRepository(doctorApi: Get.find()));
     
    Get.lazyPut<RoomRepository?>(() => RoomRepository(roomApi: Get.find()));
    Get.lazyPut(() => SpecController(specRepo: Get.find()));
    Get.lazyPut(() => ImageController());
    Get.lazyPut(() =>
        DoctorController(doctorRepository: Get.find(), ioService: Get.find()));
    Get.lazyPut(() => MainController());
    Get.lazyPut(() => HomeController());
    Get.lazyPut(() => ChatController(
        socketService: Get.find(),
        roomRepository: Get.find(),
        ));
    Get.lazyPut(() => PrescriptionController());
    Get.lazyPut(() => UserController(
        socketIOService: Get.find(), userRepository: Get.find()));
  }
}
