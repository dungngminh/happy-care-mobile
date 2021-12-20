import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:happy_care/core/themes/colors.dart';
import 'package:happy_care/modules/home/choose_doctor/choose_doctor_controller.dart';
import 'package:happy_care/widgets/custom_card_scroll.dart';
import 'package:sizer/sizer.dart';

class ChooseDoctor extends GetView<ChooseDoctorController> {
  ChooseDoctor({Key? key}) : super(key: key);

  final specName = Get.arguments as String;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: Icon(
            Icons.arrow_back,
            color: kMainColor,
            size: 26,
          ),
        ),
        centerTitle: true,
        title: Text(
          specName,
          style: GoogleFonts.openSans(
            color: kMainColor,
            fontSize: 15.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Obx(
            () => Stack(
              children: <Widget>[
                CustomCardScroll(
                  controller.currentPage.value,
                  controller.listDoctorInSpec,
                ),
                Positioned.fill(
                  child: PageView.builder(
                    itemCount: controller.listDoctorInSpec.length,
                    controller: controller.pageController,
                    reverse: true,
                    itemBuilder: (context, index) {
                      return SizedBox();
                    },
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
