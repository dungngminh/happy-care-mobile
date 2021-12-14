import 'package:cached_network_image/cached_network_image.dart';
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
            padding: EdgeInsets.symmetric(vertical: 2.2.h, horizontal: 15.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                GetBuilder<UserController>(
                  builder: (controller) {
                    final status = controller.status.value;
                    return status == UserStatus.loading
                        ? Center(
                            child: CircularProgressIndicator(),
                          )
                        : Row(
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
                              CircleAvatar(
                                backgroundColor: kMainColor,
                                child: Padding(
                                  padding: const EdgeInsets.all(2.0),
                                  child: CircleAvatar(
                                    backgroundColor: kSecondColor,
                                    backgroundImage: CachedNetworkImageProvider(
                                        controller.user.value.profile!.avatar!),
                                  ),
                                ),
                              ),
                            ],
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
