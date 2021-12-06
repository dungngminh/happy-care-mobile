import 'package:get/get.dart';

import 'package:happy_care/modules/main_screen/controller/doctor_controller.dart';
import 'package:happy_care/modules/main_screen/controller/spec_controller.dart';
import 'package:happy_care/modules/user/user_controller.dart';

enum MainStatus { loading, idle, error }

class MainController extends GetxController {
  final currentIndex = 0.obs;
  final role = "".obs;
  final status = MainStatus.idle.obs;

  void changeCurrentIndex(int newIndex) {
    currentIndex.value = newIndex;
  }

  final SpecController specController = Get.find();
  final DoctorController doctorController = Get.find();
  final UserController userController = Get.find();

  @override
  Future<void> onInit() async {
    super.onInit();
    status(MainStatus.loading);
    await userController.getUserInformation().then((value) {
      role(userController.user.value.role);
      status(MainStatus.idle);
    }).onError((error, stackTrace) {
      status(MainStatus.error);
    });
  }
}
