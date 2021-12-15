import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:happy_care/core/themes/colors.dart';
import 'package:happy_care/modules/home/home_controller.dart';
import 'package:happy_care/modules/home/web_view_screen/web_view_screen.dart';
import 'package:happy_care/widgets/custom_news_list_tile.dart';
import 'package:sizer/sizer.dart';

class MoreNews extends StatelessWidget {
  MoreNews({Key? key}) : super(key: key);

  final HomeController homeController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              child: Text(
                "Tin tức",
                style: GoogleFonts.openSans(
                  color: kMainColor,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Obx(
              () => Expanded(
                child: AnimationLimiter(
                  child: ListView.builder(
                    controller: homeController.scrollController,
                    itemCount: homeController.listNews.length + 1,
                    itemBuilder: (context, index) {
                      if (index == homeController.listNews.length) {
                        return homeController.isMoreLoading.value
                            ? Center(
                                child: CircularProgressIndicator(
                                  color: kMainColor,
                                ),
                              )
                            : SizedBox();
                      }
                      return AnimationConfiguration.staggeredList(
                        position: index,
                        duration: Duration(seconds: 1),
                        child: SlideAnimation(
                          verticalOffset: 50.0,
                          child: FadeInAnimation(
                            child: CustomNewsListTile(
                              imgUrl: homeController.listNews[index].imgUrl!,
                              title: homeController.listNews[index].title!,
                              description:
                                  homeController.listNews[index].description ??
                                      "",
                              function: () => Get.to(
                                () => WebViewScreen(
                                  title: homeController.listNews[index].title!,
                                  linkUrl: homeController.listNews[index].link!,
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
