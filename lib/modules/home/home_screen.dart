import 'package:animated_size_and_fade/animated_size_and_fade.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:happy_care/core/themes/colors.dart';
import 'package:happy_care/modules/home/home_controller.dart';
import 'package:happy_care/modules/home/more_news/more_news.dart';
import 'package:happy_care/modules/home/more_symptom/more_symptom.dart';
import 'package:happy_care/modules/home/web_view_screen/web_view_screen.dart';
import 'package:happy_care/modules/user/user_controller.dart';
import 'package:happy_care/routes/app_pages.dart';
import 'package:happy_care/widgets/custom_news_list_tile.dart';
import 'package:happy_care/widgets/search_doctor_bar.dart';
import 'package:lottie/lottie.dart';
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
              padding: EdgeInsets.only(
                  top: 2.2.h, right: 15.0, left: 15.0, bottom: 2.h),
              child: GetBuilder<UserController>(
                builder: (userController) {
                  final status = userController.status.value;
                  return status == UserStatus.loading
                      ? Center(
                          child: CircularProgressIndicator(
                            color: kMainColor,
                          ),
                        )
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Chào, ${userController.user.value.profile?.fullname ?? userController.user.value.email}",
                              style: GoogleFonts.openSans(
                                color: kMainColor,
                                fontWeight: FontWeight.w600,
                                fontSize: 14.sp,
                              ),
                            ),
                            InkWell(
                              onTap: () => controller.userStatus(0),
                              child: CircleAvatar(
                                backgroundColor: kMainColor,
                                child: Padding(
                                  padding: const EdgeInsets.all(2.0),
                                  child: CircleAvatar(
                                    backgroundImage: CachedNetworkImageProvider(
                                      userController
                                          .user.value.profile!.avatar!,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        );
                },
              ),
            ),
            Obx(() {
              final userTodayStatus = controller.userTodayStatus.value;
              return userTodayStatus == UserTodayStatus.loading
                  ? Center(
                      child: Text("Đang cập nhật trạng thái người dùng"),
                    )
                  : AnimatedSizeAndFade(
                      fadeDuration: Duration(milliseconds: 400),
                      sizeDuration: Duration(milliseconds: 400),
                      child: _buildUserStatus(),
                    );
            }),
            // ElevatedButton(
            //   onPressed: () => controller.userStatus(0),
            //   child: Text("hello"),
            // ),
            SizedBox(
              height: 1.2.h,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: Row(
                children: [
                  Text(
                    "Tìm kiếm bác sĩ theo chuyên khoa",
                    style: GoogleFonts.openSans(
                      color: kMainColor,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 1.2.h,
            ),
            SearchDoctorBar(
              function: () => Get.toNamed(AppRoutes.rSearch),
            ),
            SizedBox(
              height: 1.2.h,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Tin tức",
                    style: GoogleFonts.openSans(
                      color: kMainColor,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 0.8.h,
            ),
            Expanded(
              child: Obx(() {
                final newsStatus = controller.newsStatus.value.name;
                if (newsStatus == "loading") {
                  return Center(
                    child: CircularProgressIndicator(
                      color: kMainColor,
                    ),
                  );
                } else if (newsStatus == "error") {
                  return Center(
                    child: Column(
                      children: [
                        Icon(Icons.error, color: kMainColor),
                        SizedBox(
                          height: 0.8.h,
                        ),
                        Text("Không thể lấy được tin tức, vui lòng thử lại",
                            style: GoogleFonts.openSans(
                                color: kMainColor, fontSize: 8.sp))
                      ],
                    ),
                  );
                } else {
                  return AnimationLimiter(
                    child: RefreshIndicator(
                      color: kMainColor,
                      onRefresh: () => controller.loadAllNews(),
                      child: ListView.builder(
                        itemCount: 10,
                        itemBuilder: (context, index) {
                          if (index == 9) {
                            return Center(
                              child: Padding(
                                padding: const EdgeInsets.only(bottom: 10.0),
                                child: GestureDetector(
                                  onTap: () => Get.to(() => MoreNews()),
                                  child: Text(
                                    "Xem thêm",
                                    style: GoogleFonts.openSans(
                                      color: kMainColor,
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            );
                          } else {
                            return AnimationConfiguration.staggeredList(
                              position: index,
                              duration: const Duration(seconds: 1),
                              child: SlideAnimation(
                                verticalOffset: 50.0,
                                child: FadeInAnimation(
                                  child: CustomNewsListTile(
                                    imgUrl: controller.listNews[index].imgUrl!,
                                    title: controller.listNews[index].title!,
                                    description:
                                        controller.listNews[index].description!,
                                    function: () => Get.to(
                                      () => WebViewScreen(
                                        title:
                                            controller.listNews[index].title!,
                                        linkUrl:
                                            controller.listNews[index].link!,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            );
                          }
                        },
                      ),
                    ),
                  );
                }
              }),
            ),
          ],
        ),
      ),
    );
  }

  ///This widget used to build a user status
  Widget _buildUserStatus() {
    if (controller.userStatus.value == 0) {
      return Padding(
        padding: EdgeInsets.symmetric(horizontal: 15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Hôm nay,\nbạn cảm thấy thế nào?",
              style: GoogleFonts.openSans(
                color: kMainColor,
                fontSize: 17.sp,
                fontWeight: FontWeight.w900,
              ),
            ),
            SizedBox(
              height: 1.5.h,
            ),
            SizedBox(
              height: 18.h,
              child: Row(
                children: [
                  Expanded(
                    flex: 5,
                    child: InkWell(
                      borderRadius: BorderRadius.circular(22),
                      onTap: () => controller.onTapAction(false),
                      child: Container(
                        margin: const EdgeInsets.only(bottom: 5),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 5,
                          vertical: 15,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(22),
                          color: kMainColor,
                          boxShadow: [
                            BoxShadow(
                              offset: Offset(-1, 4),
                              color: kShadowColor,
                              blurRadius: 2,
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
                              height: 2.h,
                            ),
                            Text(
                              "Tôi cảm thấy\n rất tuyệt vời",
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
                        margin: const EdgeInsets.only(bottom: 5),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 5,
                          vertical: 15,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(22),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              offset: Offset(-1, 2),
                              color: kShadowColor,
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
                              height: 2.h,
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
          ],
        ),
      );
    } else if (controller.userStatus.value == 2) {
      return Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
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
                    color: kMainColor,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                controller.listChoice
                        .where((choice) => choice == true)
                        .toList()
                        .isNotEmpty
                    ? InkWell(
                        borderRadius: BorderRadius.circular(24),
                        onTap: () => controller.deleteAllChoices(),
                        child: Icon(
                          Icons.close,
                          color: Colors.red,
                        ),
                      )
                    : SizedBox(),
              ],
            ),
          ),
          SizedBox(height: 0.5.h),
          SizedBox(
            height: 50,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: 10,
              itemBuilder: (context, index) {
                return ChoiceChip(
                  label: Text(controller.listSymptom[index].name!),
                  labelStyle: GoogleFonts.openSans(
                      color:
                          controller.listChoice[index] ? Colors.white : null),
                  selected: controller.listChoice[index],
                  onSelected: (newBool) {
                    if (controller.listChoice
                                .where((choice) => choice == true)
                                .toList()
                                .length <
                            3 &&
                        controller.listChoice[index] == false) {
                      controller.listMax.add(controller.listSymptom[index].id!);
                      controller.listChoice[index] = newBool;
                    } else if (controller.listChoice[index] == true) {
                      controller.listChoice[index] = newBool;
                      controller.listMax
                          .remove(controller.listSymptom[index].id!);
                    }
                  },
                  selectedColor: kMainColor,
                );
              },
              separatorBuilder: (context, index) {
                return SizedBox(
                  width: 10,
                );
              },
            ),
          ),
          SizedBox(
            height: 0.8.h,
          ),
          InkWell(
            borderRadius: BorderRadius.circular(20),
            onTap: () => Get.to(() => MoreSymptomScreen()),
            child: Text(
              "Xem thêm triệu chứng",
              style: GoogleFonts.openSans(
                color: kMainColor,
                fontSize: 12.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Divider(
            color: kMainColor,
            thickness: 1,
            indent: 40.w,
            endIndent: 40.w,
          ),
          Builder(builder: (context) {
            return Obx(
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
                onPressed: () => controller.findingSpecBySymptom(context),
                child: Text("Tìm kiếm bác sĩ"),
              ),
            );
          }),
        ],
      );
    } else {
      return Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: Row(
              children: [
                Text(
                  "Chúc bạn ngày mới tốt lành!!!",
                  style: GoogleFonts.openSans(
                    fontSize: 16.sp,
                    color: kMainColor,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ],
            ),
          ),
          Lottie.asset("assets/lottie/happy.json", height: 15.h),
        ],
      );
    }
  }
}
