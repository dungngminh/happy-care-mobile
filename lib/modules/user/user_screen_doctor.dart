import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:happy_care/core/themes/colors.dart';
import 'package:happy_care/core/utils/custom_cache_manager.dart';
import 'package:happy_care/modules/user/user_controller.dart';
import 'package:happy_care/routes/app_pages.dart';
import 'package:happy_care/widgets/custom_text_field.dart';
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
                                  backgroundColor: Colors.white,
                                    backgroundImage:
                                        Image.asset("assets/images/doctor.png")
                                            .image,
                                  )
                                : CircleAvatar(
                                    backgroundColor: kMainColor,
                                    backgroundImage: CachedNetworkImageProvider(
                                      controller.user.value.profile!.avatar!,
                                      cacheManager:
                                          CustomCacheManager.customCacheManager,
                                    ),
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
                      InformationTile(
                        icon: Icons.lock_rounded,
                        title: 'Thay đổi mật khẩu',
                        subtitle: "Nhấn và giữ để thay đổi mật khẩu",
                        onLongPress: () {
                          showDialog(
                              context: context,
                              builder: (context) {
                                return GestureDetector(
                                  onTap: () => FocusManager
                                      .instance.primaryFocus
                                      ?.unfocus(),
                                  child: AlertDialog(
                                    title: Text(
                                      "Đổi mật khẩu",
                                      style: GoogleFonts.openSans(
                                          color: kMainColor,
                                          fontWeight: FontWeight.w700),
                                    ),
                                    content: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Obx(
                                          () => CustomTextField(
                                            controller:
                                                controller.oldPassController,
                                            icon: Icons.password_outlined,
                                            labelText: 'Mật khẩu cũ',
                                            hintText: 'Nhập lại mật khẩu cũ',
                                            isPassword: true,
                                            isPasswordHide:
                                                controller.hide1.value,
                                            onPasswordTap: () {
                                              controller.hide1(
                                                  !controller.hide1.value);
                                            },
                                          ),
                                        ),
                                        SizedBox(
                                          height: 1.2.h,
                                        ),
                                        Obx(
                                          () => CustomTextField(
                                            controller:
                                                controller.newPassController,
                                            icon: Icons.password_outlined,
                                            labelText: 'Mật khẩu mới',
                                            hintText: 'Nhập mật khẩu mới',
                                            isPassword: true,
                                            isPasswordHide:
                                                controller.hide2.value,
                                            onPasswordTap: () {
                                              controller.hide2(
                                                  !controller.hide2.value);
                                            },
                                          ),
                                        ),
                                        SizedBox(
                                          height: 1.2.h,
                                        ),
                                        Obx(
                                          () => CustomTextField(
                                            controller:
                                                controller.rePassController,
                                            icon: Icons.password_outlined,
                                            labelText: 'Nhập lại mật khẩu mới',
                                            hintText: 'Nhập lại mật khẩu mới',
                                            isPassword: true,
                                            isPasswordHide:
                                                controller.hide3.value,
                                            onPasswordTap: () {
                                              controller.hide3(
                                                  !controller.hide3.value);
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                    actions: [
                                      TextButton(
                                        onPressed: () =>
                                            controller.changePassword(context),
                                        child: Text(
                                          "Thay đổi",
                                          style: GoogleFonts.openSans(
                                            color: kMainColor,
                                          ),
                                        ),
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          controller.resetValue();
                                          Get.back();
                                        },
                                        child: Text(
                                          "Hủy",
                                          style: GoogleFonts.openSans(
                                            color: kMainColor,
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                );
                              });
                        },
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
