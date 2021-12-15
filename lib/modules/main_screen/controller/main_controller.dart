import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:happy_care/core/themes/colors.dart';
import 'package:happy_care/data/repositories/user_repository.dart';

import 'package:happy_care/modules/main_screen/controller/doctor_controller.dart';
import 'package:happy_care/modules/main_screen/controller/spec_controller.dart';
import 'package:happy_care/modules/main_screen/main_screen.dart';
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
  final UserRepository? userRepository;

  MainController({this.userRepository});

  @override
  Future<void> onInit() async {
    super.onInit();
    status(MainStatus.loading);

    await userRepository!.getUserData().then((value) {
      role(value.role);
      status(MainStatus.idle);
      Get.back();
    }).onError((error, stackTrace) {
      status(MainStatus.error);
    });
  }
}
