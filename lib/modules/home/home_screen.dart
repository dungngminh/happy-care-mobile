import 'package:animated_size_and_fade/animated_size_and_fade.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:happy_care/core/themes/colors.dart';
import 'package:happy_care/modules/home/home_controller.dart';
import 'package:happy_care/modules/user/user_controller.dart';
import 'package:sizer/sizer.dart';

class HomeScreen extends GetView<HomeController> {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(vertical: 2.2.h, horizontal: 15.0),
              child: GetBuilder<UserController>(
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
                              "Chào, ${controller.user.value.profile?.fullname ?? controller.user.value.email}",
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
                                  backgroundImage: CachedNetworkImageProvider(
                                    controller.user.value.profile!.avatar!,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        );
                },
              ),
            ),
            SizedBox(
              height: 1.h,
            ),

            Obx(
              () => AnimatedSizeAndFade.showHide(
                show: controller.toggle.value,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15.0),
                  child: _buildUserStatus(),
                ),
              ),
            ),
            Container(
              height: 300,
              color: Colors.red,
            )
            // Obx(
            //   () => AnimatedSwitcher(
            //     duration: Duration(seconds: 1),
            //     transitionBuilder: (child, animation) =>
            //         ScaleTransition(scale: animation, child: child),
            //     child: _buildUserStatus(),
            //   ),
            //   //TransformTrans
            // ),
            // Row(
            //   children: [
            //     Text(
            //       "Triệu chứng của bạn là gì?",
            //       style: GoogleFonts.openSans(
            //         fontSize: 14.sp,
            //         color: kTextMainColor,
            //         fontWeight: FontWeight.bold,
            //       ),
            //     ),
            //   ],
            // ),
          ],
        ),
      ),
    );
  }

  ///This widget used to build a user status
  Widget _buildUserStatus() {
    if (controller.userStatus.value == 0) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Hôm nay,\nbạn cảm thấy thế nào?",
            style: GoogleFonts.openSans(
              color: kTextMainColor,
              fontSize: 16.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            height: 1.5.h,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5.0),
            child: SizedBox(
              height: 18.h,
              child: Row(
                children: [
                  Expanded(
                    flex: 5,
                    child: InkWell(
                      borderRadius: BorderRadius.circular(22),
                      onTap: () => controller.onTapAction(false),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 5, vertical: 20),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(22),
                          color: kMainColor,
                          boxShadow: [
                            BoxShadow(
                              offset: Offset(-1, 2),
                              color: Colors.black.withOpacity(0.25),
                              blurRadius: 4,
                            ),
                          ],
                        ),
                        child: Column(
                          children: [
                            CircleAvatar(
                                radius: 22,
                                backgroundColor: Color(0xffF9F9F9),
                                child: Padding(
                                  padding: const EdgeInsets.all(1.0),
                                  child: CircleAvatar(
                                    backgroundColor: Colors.transparent,
                                    backgroundImage:
                                        Image.asset("assets/icons/happy.png")
                                            .image,
                                  ),
                                )),
                            SizedBox(
                              height: 1.5.h,
                            ),
                            Text(
                              "Tôi cảm thấy\nkhỏe mạnh",
                              style: GoogleFonts.openSans(
                                color: Colors.white,
                                fontSize: 11.sp,
                                fontWeight: FontWeight.w700,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Spacer(),
                  Expanded(
                    flex: 5,
                    child: InkWell(
                      borderRadius: BorderRadius.circular(22),
                      onTap: () => controller.onTapAction(true),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 5,
                          vertical: 20,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(22),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              offset: Offset(-1, 2),
                              color: Colors.black.withOpacity(0.25),
                              blurRadius: 4,
                            ),
                          ],
                        ),
                        child: Column(
                          children: [
                            CircleAvatar(
                                radius: 22,
                                backgroundColor: Color(0xffF0EEFA),
                                child: Padding(
                                  padding: const EdgeInsets.all(1.0),
                                  child: CircleAvatar(
                                    backgroundColor: Colors.transparent,
                                    backgroundImage:
                                        Image.asset("assets/icons/sick.png")
                                            .image,
                                  ),
                                )),
                            SizedBox(
                              height: 1.5.h,
                            ),
                            Text(
                              "Tôi cảm thấy\nkhông được khỏe",
                              style: GoogleFonts.openSans(
                                color: kTextMainColor,
                                fontSize: 11.sp,
                                fontWeight: FontWeight.w700,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      );
    } else if (controller.userStatus.value == 2) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Triệu chứng của bạn là gì?",
              style: GoogleFonts.openSans(
                fontSize: 14.sp,
                color: kTextMainColor,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              "Xem thêm",
              style: GoogleFonts.openSans(
                fontSize: 12.sp,
                color: Colors.red,
                fontWeight: FontWeight.w700,
              ),
            )
          ],
        ),
      );
    } else {
      return SizedBox();
    }
  }
}
