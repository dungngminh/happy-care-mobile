import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:happy_care/core/themes/colors.dart';
import 'package:sizer/sizer.dart';

import '../home_controller.dart';

class MoreSymptomScreen extends StatelessWidget {
  MoreSymptomScreen({Key? key}) : super(key: key);

  final HomeController controller = Get.find();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(top: 2.2.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        InkWell(
                          borderRadius: BorderRadius.circular(24),
                          onTap: () => Get.back(),
                          child: Icon(
                            Icons.arrow_back,
                            color: kMainColor,
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Obx(
                          () => Text(
                            "Triệu chứng của bạn là gì? (" +
                                controller.listChoice
                                    .where((choice) => choice == true)
                                    .toList()
                                    .length
                                    .toString() +
                                "/" +
                                "3)",
                            style: GoogleFonts.openSans(
                              fontSize: 14.sp,
                              color: kTextMainColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Obx(
                      () => controller.listChoice
                              .where((choice) => choice == true)
                              .toList()
                              .isNotEmpty
                          ? InkWell(
                              onTap: () => controller.deleteAllChoices(),
                              child: Icon(
                                Icons.close,
                                color: Colors.red,
                              ),
                            )
                          : SizedBox(),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 1.2.h),
              Obx(
                () => Wrap(
                  spacing: 1.5.w,
                  children: [
                    for (int i = 0; i < controller.listSymptom.length; i++)
                      ChoiceChip(
                        label: Text(controller.listSymptom[i].name!),
                        selected: controller.listChoice[i],
                        labelStyle: GoogleFonts.openSans(
                            color:
                                controller.listChoice[i] ? Colors.white : null),
                        onSelected: (newBool) {
                          if (controller.listChoice
                                      .where((choice) => choice == true)
                                      .toList()
                                      .length <
                                  3 &&
                              controller.listChoice[i] == false) {
                            controller.listMax
                                .add(controller.listSymptom[i].id!);
                            controller.listChoice[i] = newBool;
                          } else if (controller.listChoice[i] == true) {
                            controller.listChoice[i] = newBool;
                            controller.listMax
                                .remove(controller.listSymptom[i].id!);
                          }
                        },
                        selectedColor: kMainColor,
                      ),
                  ],
                ),
              ),
              SizedBox(height: 1.2.h),
              Builder(builder: (context) {
                return Center(
                  child: Obx(
                    () => ElevatedButton(
                      style: controller.listChoice
                              .where((choice) => choice == true)
                              .toList()
                              .isNotEmpty
                          ? ElevatedButton.styleFrom(
                              primary: kMainColor,
                              elevation: 4,
                              textStyle: GoogleFonts.openSans(),
                            )
                          : ElevatedButton.styleFrom(
                              primary: Colors.grey.shade200,
                              onPrimary: Colors.grey,
                              elevation: 1,
                              textStyle: GoogleFonts.openSans(),
                            ),
                      onPressed: () => controller.findingSpecBySymptom(context,
                          isMore: true),
                      child: Text("Tìm kiếm bác sĩ"),
                    ),
                  ),
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}
