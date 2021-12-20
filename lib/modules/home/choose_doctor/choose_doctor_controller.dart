import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:happy_care/data/models/user.dart';
import 'package:happy_care/modules/main_screen/controller/doctor_controller.dart';

enum ChooseDoctorStatus { loading, done, error }

class ChooseDoctorController extends GetxController {
  final DoctorController doctorController = Get.find();
  final listDoctorInSpec = RxList(<User>[]);
  late final PageController pageController;
  final currentPage = 0.0.obs;

  @override
  void onInit() {
    super.onInit();
    final specName = Get.arguments as String;
    print("specId" + specName);
    listDoctorInSpec(doctorController.listDoctor
        .where((doctor) => doctor.specializations!.first.contains(specName))
        .toList());
    pageController = PageController(initialPage: listDoctorInSpec.length - 1);
    currentPage(listDoctorInSpec.length - 1.0);
    pageController.addListener(() {
      currentPage(pageController.page);
    });
  }
}
