import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:happy_care/core/themes/colors.dart';
import 'package:happy_care/modules/home/home_controller.dart';
import 'package:happy_care/modules/user/user_controller.dart';
import 'package:sizer/sizer.dart';

class HomeDoctorScreen extends GetView<HomeController> {
  const HomeDoctorScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 3.h),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                GetBuilder<UserController>(
                  builder: (controller) {
                    final status = controller.status.value;
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            status != UserStatus.loading
                                ? "Chào, Bác sĩ ${controller.user.value.profile?.fullname ?? controller.user.value.email}"
                                : "Chào",
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: GoogleFonts.openSans(
                              color: kMainColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 14.sp,
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}