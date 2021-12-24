import 'package:get/get.dart';
import 'package:happy_care/data/api/drug_api.dart';
import 'package:happy_care/data/api/mess_api.dart';
import 'package:happy_care/data/api/news_api.dart';
import 'package:happy_care/data/api/prescription_api.dart';
import 'package:happy_care/data/api/symptom_api.dart';
import 'package:happy_care/data/repositories/doctor_repository.dart';
import 'package:happy_care/data/repositories/drug_repository.dart';
import 'package:happy_care/data/repositories/mess_repository.dart';
import 'package:happy_care/data/repositories/news_repository.dart';
import 'package:happy_care/data/repositories/prescription_repository.dart';
import 'package:happy_care/data/repositories/room_repository.dart';
import 'package:happy_care/data/repositories/spec_repository.dart';
import 'package:happy_care/data/repositories/symptom_repository.dart';
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

class MainBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<UserApi?>(() => UserApi(Get.find()));
    Get.lazyPut<SpecApi?>(() => SpecApi(Get.find()));
    Get.lazyPut<RoomApi?>(() => RoomApi(Get.find()));
    Get.lazyPut<DoctorApi?>(() => DoctorApi(Get.find()));
    Get.lazyPut<MessApi?>(() => MessApi(Get.find()));
    Get.lazyPut<NewsApi?>(() => NewsApi(Get.find()));
    Get.lazyPut<SymptomApi?>(() => SymptomApi(Get.find()));
    Get.lazyPut<DrugApi?>(() => DrugApi(Get.find()));
    Get.lazyPut<PrescriptionApi?>(() => PrescriptionApi(Get.find()));
    Get.lazyPut<PrescriptionRepository?>(
        () => PrescriptionRepository(prescriptionApi: Get.find()));
    Get.lazyPut<DrugRepository?>(() => DrugRepository(drugApi: Get.find()));
    Get.lazyPut<NewsReposity?>(() => NewsReposity(newsApi: Get.find()));
    Get.lazyPut<SymptomRepository?>(
        () => SymptomRepository(symptomApi: Get.find()));
    Get.lazyPut<SocketIOService?>(() => SocketIOService());
    Get.lazyPut<MyCloudinaryService?>(() => MyCloudinaryService());
    Get.lazyPut<UserRepository?>(() => UserRepository(userApi: Get.find()));
    Get.lazyPut<SpecializationRepository?>(
        () => SpecializationRepository(specApi: Get.find()));
    Get.lazyPut<DoctorRepository?>(
        () => DoctorRepository(doctorApi: Get.find()));
    Get.lazyPut<MessRepository?>(() => MessRepository(messApi: Get.find()));
    Get.lazyPut<RoomRepository?>(() => RoomRepository(roomApi: Get.find()));
    Get.lazyPut(() => SpecController(specRepo: Get.find()));
    Get.lazyPut(() => ImageController());
    Get.lazyPut(() => DoctorController(
          doctorRepository: Get.find(),
          ioService: Get.find(),
        ));
    Get.lazyPut(() => MainController(userRepository: Get.find()));
    Get.lazyPut(() => HomeController(
          newsReposity: Get.find(),
          symptomRepository: Get.find(),
        ));
    Get.lazyPut(() => PrescriptionController(
          drugRepository: Get.find(),
          prescriptionRepository: Get.find(),
        ));
    Get.lazyPut(() => ChatController(
          socketService: Get.find(),
          roomRepository: Get.find(),
          messRepository: Get.find(),
        ));
    Get.lazyPut(() => PrescriptionController());
    Get.lazyPut(() => UserController(
          socketIOService: Get.find(),
          userRepository: Get.find(),
        ));
  }
}
