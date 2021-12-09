import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:happy_care/core/themes/colors.dart';
import 'package:happy_care/modules/user/user_controller.dart';
import 'package:happy_care/routes/app_pages.dart';
import 'package:happy_care/widgets/information_tile.dart';
import 'package:sizer/sizer.dart';

class UserDoctorScreen extends GetView<UserController> {
  const UserDoctorScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: RefreshIndicator(
          color: kMainColor,
          onRefresh: () => controller.getUserInformation(),
          child: ListView(
            children: [
              Container(
                height: 40.h,
                padding: EdgeInsets.symmetric(vertical: 1.8.h),
                width: double.infinity,
                decoration: BoxDecoration(
                  color: kMainColor,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(45),
                    bottomRight: Radius.circular(45),
                  ),
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Spacer(flex: 2),
                        Obx(() {
                          final status = controller.status.value;
                          return Text(
                              status == UserStatus.loading
                                  ? "Đang cập nhật"
                                  : status == UserStatus.done
                                      ? (controller.user.value.background?.first
                                              .degree
                                              ?.toUpperCase() ??
                                          "")
                                      : "",
                              style: GoogleFonts.openSans(
                                color: Colors.white,
                                fontSize: 15.sp,
                                fontWeight: FontWeight.bold,
                              ));
                        }),
                        Spacer(),
                        Expanded(
                          child: IconButton(
                            onPressed: () async {
                              var result = await Get.toNamed(AppRoutes.rEdit);
                              if (result != null) {
                                controller.getUserInformation();
                              }
                            },
                            icon: Icon(
                              Icons.edit,
                              color: Colors.white,
                              size: 26,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 1.5.h,
                    ),
                    SizedBox(
                      height: 20.h,
                      width: 20.h,
                      child: CircleAvatar(
                        backgroundColor: kSecondColor,
                        child: SizedBox(
                          height: 19.h,
                          width: 19.h,
                          child:
                              GetBuilder<UserController>(builder: (controller) {
                            return controller.user.value.profile?.avatar == null
                                ? CircleAvatar(
                                    backgroundImage:
                                        Image.asset("assets/images/icon.png")
                                            .image,
                                  )
                                : CircleAvatar(
                                    backgroundImage: CachedNetworkImageProvider(
                                        controller.user.value.profile!.avatar!),
                                  );
                          }),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 2.h,
                    ),
                    Obx(() {
                      final status = controller.status.value;
                      return Text(
                        status == UserStatus.loading
                            ? "Đang cập nhật"
                            : controller.user.value.profile?.fullname ??
                                controller.user.value.email,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.openSans(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize:
                              controller.user.value.profile?.fullname != null
                                  ? 19.sp
                                  : 16.sp,
                        ),
                      );
                    }),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20.0,
                  vertical: 10.0,
                ),
                child: Obx(() {
                  final status = controller.status.value;
                  return Column(
                    children: [
                      InformationTile(
                        icon: Icons.school,
                        title: 'Chuyên ngành',
                        subtitle: status == UserStatus.loading
                            ? "Đang cập nhật"
                            : controller.user.value.specializations?.first,
                      ),
                      InformationTile(
                        icon: Icons.work_rounded,
                        title: 'Đơn vị công tác',
                        subtitle: status == UserStatus.loading
                            ? "Đang cập nhật"
                            : controller
                                .user.value.background?.first.workLocation,
                      ),
                      InformationTile(
                        icon: Icons.mail,
                        title: 'Email',
                        subtitle: status == UserStatus.loading
                            ? "Đang cập nhật"
                            : controller.user.value.email,
                      ),
                      InformationTile(
                        icon: Icons.badge_rounded,
                        title: 'Tuổi',
                        subtitle: status == UserStatus.loading
                            ? "Đang cập nhật"
                            : (controller.user.value.profile?.age == null
                                ? null
                                : controller.user.value.profile!.age
                                    .toString()),
                      ),
                      InformationTile(
                        icon: Icons.phone,
                        title: 'Số điện thoại',
                        subtitle: status == UserStatus.loading
                            ? "Đang cập nhật"
                            : controller.user.value.profile?.phone,
                      ),
                      InformationTile(
                        icon: Icons.location_pin,
                        title: 'Địa chỉ',
                        subtitle: status == UserStatus.loading
                            ? "Đang cập nhật"
                            : controller.user.value.profile?.address,
                      ),
                      GestureDetector(
                        onTap: () => controller.signOut(context),
                        child: Container(
                          height: 50,
                          margin: EdgeInsets.symmetric(
                              horizontal: 18.w, vertical: 2.h),
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25),
                            color: kMainColor,
                          ),
                          child: Center(
                            child: Text(
                              "Đăng xuất".toUpperCase(),
                              style: GoogleFonts.openSans(
                                fontSize: 14.sp,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
