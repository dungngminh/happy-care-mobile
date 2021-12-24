import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:happy_care/core/themes/colors.dart';
import 'package:happy_care/core/utils/custom_cache_manager.dart';

import 'package:happy_care/modules/prescription/prescription_controller.dart';
import 'package:happy_care/modules/user/user_controller.dart';
import 'package:happy_care/routes/app_pages.dart';
import 'package:sizer/sizer.dart';

class PrescriptionScreen extends GetView<PrescriptionController> {
  const PrescriptionScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(left: 15, right: 15, top: 5.h),
            child: Row(
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
                              SizedBox(
                                width: 4.w,
                              ),
                              Text(
                                "Đơn thuốc",
                                style: GoogleFonts.openSans(
                                    color: kMainColor,
                                    fontSize: 15.sp,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          );
                  },
                ),
              ],
            ),
          ),
          SizedBox(
            height: 0.8.h,
          ),
          Center(
            child: Obx(
              () => Text(
                "Cập nhật lần cuối vào lúc ${controller.time}",
                style: GoogleFonts.openSans(
                  fontStyle: FontStyle.italic,
                ),
              ),
            ),
          ),
          SizedBox(
            height: 0.8.h,
          ),
          Expanded(
            child: RefreshIndicator(
              onRefresh: () => controller.getMyPresciptions(),
              color: kMainColor,
              child: Obx(() {
                final status = controller.prescriptionStatus.value;
                if (status == PrescriptionStatus.loading) {
                  return Center(
                    child: CircularProgressIndicator(
                      color: kMainColor,
                    ),
                  );
                } else if (status == PrescriptionStatus.error) {
                  return Center(
                    child: Column(
                      children: [
                        Icon(
                          Icons.error,
                          color: kMainColor,
                        ),
                        Text(
                            "Có lỗi xảy ra, vui lòng kéo xuống để cập nhật lại",
                            style: GoogleFonts.openSans(color: kMainColor))
                      ],
                    ),
                  );
                } else {
                  return AnimationLimiter(
                    child: ListView.builder(
                        padding: EdgeInsets.zero,
                        itemCount: controller.prescriptionList.length,
                        itemBuilder: (context, index) {
                          return AnimationConfiguration.staggeredList(
                            position: index,
                            duration: const Duration(seconds: 1),
                            child: SlideAnimation(
                              verticalOffset: 50.0,
                              child: FadeInAnimation(
                                child: Container(
                                  padding: EdgeInsets.all(12),
                                  margin: EdgeInsets.symmetric(
                                      horizontal: 3.w, vertical: 1.2.h),
                                  height: 18.h,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(25),
                                    boxShadow: [
                                      BoxShadow(
                                          color: kShadowColor,
                                          blurRadius: 10,
                                          offset: Offset(0, 4))
                                    ],
                                  ),
                                  child: InkWell(
                                    onTap: () => Get.toNamed(
                                      AppRoutes.rDetailPrescription,
                                      arguments:
                                          controller.prescriptionList[index],
                                    ),
                                    child: Row(
                                      children: [
                                        Container(
                                          width: 14.h,
                                          decoration: BoxDecoration(
                                            image: DecorationImage(
                                              image: Image.asset(
                                                      "assets/images/drug.png")
                                                  .image,
                                              fit: BoxFit.fitHeight,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(15),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 5.w,
                                        ),
                                        Expanded(
                                          flex: 9,
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 6.0),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                RichText(
                                                  text: TextSpan(children: [
                                                    TextSpan(
                                                      text: "Đơn thuốc: ",
                                                      style:
                                                          GoogleFonts.openSans(
                                                        fontSize: 11.sp,
                                                        color: kMainColor,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                    TextSpan(
                                                      text:
                                                          "${controller.prescriptionList[index].id!.substring(0, 5)}..${controller.prescriptionList[index].id!.substring(controller.prescriptionList[index].id!.length - 6, controller.prescriptionList[index].id!.length - 1)}",
                                                      style:
                                                          GoogleFonts.openSans(
                                                        fontSize: 11.sp,
                                                        color: kMainColor,
                                                      ),
                                                    )
                                                  ]),
                                                ),
                                                SizedBox(
                                                  height: 1.h,
                                                ),
                                                RichText(
                                                  text: TextSpan(children: [
                                                    TextSpan(
                                                      text: "Chuẩn đoán: ",
                                                      style:
                                                          GoogleFonts.openSans(
                                                        fontSize: 11.sp,
                                                        color: kMainColor,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                    TextSpan(
                                                      text: controller
                                                          .prescriptionList[
                                                              index]
                                                          .diagnose,
                                                      style:
                                                          GoogleFonts.openSans(
                                                        fontSize: 11.sp,
                                                        color: kMainColor,
                                                      ),
                                                    )
                                                  ]),
                                                ),
                                                SizedBox(
                                                  height: 1.h,
                                                ),
                                                RichText(
                                                  text: TextSpan(children: [
                                                    TextSpan(
                                                      text: "Số lượng thuốc: ",
                                                      style:
                                                          GoogleFonts.openSans(
                                                        fontSize: 11.sp,
                                                        color: kMainColor,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                    TextSpan(
                                                      text: controller
                                                          .prescriptionList[
                                                              index]
                                                          .medicines!
                                                          .length
                                                          .toString(),
                                                      style:
                                                          GoogleFonts.openSans(
                                                        fontSize: 11.sp,
                                                        color: kMainColor,
                                                      ),
                                                    )
                                                  ]),
                                                ),
                                                SizedBox(
                                                  height: 1.h,
                                                ),
                                                RichText(
                                                  text: TextSpan(children: [
                                                    TextSpan(
                                                      text: "Ngày tạo: ",
                                                      style:
                                                          GoogleFonts.openSans(
                                                        fontSize: 11.sp,
                                                        color: kMainColor,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                    TextSpan(
                                                      text: DateTime.parse(
                                                        controller
                                                            .prescriptionList[
                                                                index]
                                                            .date!,
                                                      )
                                                          .toLocal()
                                                          .toString()
                                                          .substring(0, 16),
                                                      style:
                                                          GoogleFonts.openSans(
                                                        fontSize: 11.sp,
                                                        color: kMainColor,
                                                      ),
                                                    )
                                                  ]),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          child: Column(
                                            children: [
                                              InkWell(
                                                borderRadius:
                                                    BorderRadius.circular(24),
                                                onTap: () {},
                                                child: Icon(
                                                  Icons.close,
                                                  color: Colors.red,
                                                ),
                                              ),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          );
                        }),
                  );
                }
              }),
            ),
          ),
        ],
      ),
    );
  }
}
