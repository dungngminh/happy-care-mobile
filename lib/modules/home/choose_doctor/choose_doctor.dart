import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:happy_care/core/themes/colors.dart';
import 'package:happy_care/modules/home/choose_doctor/choose_doctor_controller.dart';
import 'package:happy_care/widgets/custom_card_scroll.dart';
import 'package:sizer/sizer.dart';

class ChooseDoctor extends GetWidget<ChooseDoctorController> {
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
      body: SingleChildScrollView(
        child: Column(
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
                      onPageChanged: controller.onPageChanged,
                    ),
                  ),
                ],
              ),
            ),
            Obx(
              () => Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      controller.listDoctorInSpec[controller.currentIndex.value]
                              .background!.first.degree! +
                          " - " +
                          controller
                              .listDoctorInSpec[controller.currentIndex.value]
                              .profile!
                              .fullname!,
                      style: GoogleFonts.openSans(
                        color: kMainColor,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: 0.5.h,
                    ),
                    Text(
                      controller.listDoctorInSpec[controller.currentIndex.value]
                              .specializations!.first +
                          " - " +
                          controller
                              .listDoctorInSpec[controller.currentIndex.value]
                              .background!
                              .first
                              .workLocation!,
                      style: GoogleFonts.openSans(
                        color: Colors.grey.shade600,
                        fontSize: 13.sp,
                      ),
                    ),
                    SizedBox(
                      height: 1.5.h,
                    ),
                    Text(
                      "Giới thiệu",
                      style: GoogleFonts.openSans(
                        color: kMainColor,
                        fontSize: 13.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: 0.8.h,
                    ),
                    Text(
                      controller.listDoctorInSpec[controller.currentIndex.value]
                          .background!.first.gioithieu!,
                      style: GoogleFonts.openSans(
                        color: Colors.grey.shade600,
                        fontSize: 10.sp,
                      ),
                      textAlign: TextAlign.justify,
                    ),
                  ],
                ),
              ),
            ),
            Builder(builder: (context) {
              return Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GestureDetector(
                    onTap: () => controller.joinRoom(
                        context,
                        controller
                            .listDoctorInSpec[controller.currentIndex.value]),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25),
                        color: kMainColor,
                      ),
                      height: 8.h,
                      child: Center(
                        child: Text(
                          "Trò chuyện với bác sĩ",
                          style: GoogleFonts.openSans(
                            fontSize: 13.sp,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}
