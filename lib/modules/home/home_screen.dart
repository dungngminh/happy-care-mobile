import 'package:animated_size_and_fade/animated_size_and_fade.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:happy_care/core/themes/colors.dart';
import 'package:happy_care/modules/home/home_controller.dart';
import 'package:happy_care/modules/home/more_news/more_news.dart';
import 'package:happy_care/modules/home/web_view_screen/web_view_screen.dart';
import 'package:happy_care/modules/user/user_controller.dart';
import 'package:happy_care/widgets/custom_news_list_tile.dart';
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
                  top: 2.2.h, right: 15.0, left: 15.0, bottom: 1.h),
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
            Obx(
              () => AnimatedSizeAndFade(
                fadeDuration: Duration(milliseconds: 400),
                sizeDuration: Duration(milliseconds: 400),
                child: _buildUserStatus(),
              ),
            ),
            ElevatedButton(
              onPressed: () => controller.userStatus(0),
              child: Text("hello"),
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
                                        title: controller.listNews[index].title!,
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
                          margin: const EdgeInsets.only(bottom: 5),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 5,
                            vertical: 18,
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
                                height: 2.2.h,
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
                            vertical: 18,
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
                                height: 2.2.h,
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
                ),
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
                  label: Row(
                    children: [
                      Icon(
                        Icons.favorite,
                        color: Colors.red,
                      ),
                      SizedBox(
                        width: 1.w,
                      ),
                      Text("Đau đầu"),
                    ],
                  ),
                  selected: false,
                );
              },
              separatorBuilder: (context, index) {
                return SizedBox(
                  width: 10,
                );
              },
            ),
          ),
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
                  "Chúc bạn ngày mới tốt lành",
                  style: GoogleFonts.openSans(
                    fontSize: 14.sp,
                    color: kTextMainColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      );
    }
  }
}
