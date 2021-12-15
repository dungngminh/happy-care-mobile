import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:happy_care/core/themes/colors.dart';
import 'package:happy_care/core/utils/custom_cache_manager.dart';
import 'package:happy_care/modules/home/home_controller.dart';
import 'package:happy_care/modules/user/user_controller.dart';
import 'package:happy_care/widgets/custom_news_list_tile.dart';
import 'package:sizer/sizer.dart';

import 'more_news/more_news.dart';
import 'web_view_screen/web_view_screen.dart';

class HomeDoctorScreen extends GetView<HomeController> {
  const HomeDoctorScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(top: 2.2.h, bottom: 1.h),
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
                      : Padding(
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
                              CircleAvatar(
                                backgroundColor: kMainColor,
                                child: Padding(
                                  padding: const EdgeInsets.all(2.0),
                                  child: CircleAvatar(
                                    backgroundColor: kSecondColor,
                                    backgroundImage: CachedNetworkImageProvider(
                                      controller.user.value.profile!.avatar!,
                                      cacheManager:
                                          CustomCacheManager.customCacheManager,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                },
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
                                      imgUrl:
                                          controller.listNews[index].imgUrl!,
                                      title: controller.listNews[index].title!,
                                      description: controller
                                          .listNews[index].description!,
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
      ),
    );
  }
}
