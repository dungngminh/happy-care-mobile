import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:happy_care/core/themes/colors.dart';
import 'package:happy_care/data/models/room_chat/room_chat_pass.dart';
import 'package:happy_care/data/models/user.dart';
import 'package:happy_care/modules/chat/chat_controller.dart';
import 'package:happy_care/modules/main_screen/controller/doctor_controller.dart';
import 'package:happy_care/routes/app_pages.dart';
import 'package:sizer/sizer.dart';

enum ChooseDoctorStatus { loading, done, error }

class ChooseDoctorController extends GetxController {
  final DoctorController doctorController = Get.find();
  final ChatController chatController = Get.find();
  final listDoctorInSpec = RxList(<User>[]);
  final opacityText = RxList(<double>[]);
  late final PageController pageController;
  final currentPage = 0.0.obs;
  final currentIndex = 0.obs;
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
      print(currentPage.value);
    });
  }

  onPageChanged(int index) {
    currentIndex(index);
  }

  joinRoom(BuildContext context, User doctor) async {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircularProgressIndicator(
                  color: kMainColor,
                ),
                SizedBox(
                  height: 1.2.h,
                ),
                Text("Đang join phòng...",
                    style: GoogleFonts.openSans(
                        color: Colors.white, fontWeight: FontWeight.w700)),
              ],
            ),
          );
        });
    await chatController
        .joinFirstToChatRoom(notUserId: doctor.id)
        .then((value) {
      Get.back();
      Get.toNamed(AppRoutes.rChatRoom, arguments: RoomChatPass(value!, doctor));
    });
  }
}
