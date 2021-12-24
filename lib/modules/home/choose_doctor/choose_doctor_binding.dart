import 'package:get/get.dart';
import 'package:happy_care/modules/home/choose_doctor/choose_doctor_controller.dart';

class ChooseDoctorBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ChooseDoctorController());
  }
}
