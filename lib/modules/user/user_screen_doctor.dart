import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:happy_care/core/themes/colors.dart';
import 'package:happy_care/modules/user/user_controller.dart';
import 'package:happy_care/routes/app_pages.dart';
import 'package:happy_care/widgets/information_tile.dart';

class UserDoctorScreen extends GetView<UserController> {
  const UserDoctorScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Center(
        child: RefreshIndicator(
          color: kMainColor,
          onRefresh: () => controller.getUserInformation(),
          child: ListView(
            children: [
              Container(
                height: size.height * 0.42,
                padding: const EdgeInsets.symmetric(vertical: 20),
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
                              status == Status.loading
                                  ? "Đang cập nhật"
                                  : (controller
                                          .user.value.background?.first.degree
                                          ?.toUpperCase() ??
                                      ""),
                              style: GoogleFonts.openSans(
                                color: Colors.white,
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ));
                        }),
                        Spacer(),
                        Expanded(
                          child: IconButton(
                            onPressed: () async {
                              bool result = await Get.toNamed(AppRoutes.rEdit);
                              if (result) {
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
                      height: 10,
                    ),
                    SizedBox(
                      height: 160,
                      width: 160,
                      child: CircleAvatar(
                        backgroundColor: kSecondColor,
                        child: SizedBox(
                          height: 150,
                          width: 150,
                          child: CircleAvatar(
                            backgroundImage:
                                Image.asset("assets/images/icon.png").image,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Obx(() {
                      final status = controller.status.value;
                      return Text(
                        status == Status.loading
                            ? "Đang cập nhật"
                            : controller.user.value.profile?.fullname ??
                                controller.user.value.email,
                        style: GoogleFonts.openSans(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize:
                              controller.user.value.profile?.fullname != null
                                  ? 24
                                  : 20,
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
                        subtitle: status == Status.loading
                            ? "Đang cập nhật"
                            : controller.user.value.specializations?.first,
                      ),
                      InformationTile(
                        icon: Icons.work_rounded,
                        title: 'Đơn vị công tác',
                        subtitle: status == Status.loading
                            ? "Đang cập nhật"
                            : controller
                                .user.value.background?.first.workLocation,
                      ),
                      InformationTile(
                        icon: Icons.mail,
                        title: 'Email',
                        subtitle: status == Status.loading
                            ? "Đang cập nhật"
                            : controller.user.value.email,
                      ),
                      InformationTile(
                        icon: Icons.badge_rounded,
                        title: 'Tuổi',
                        subtitle: status == Status.loading
                            ? "Đang cập nhật"
                            : controller.user.value.profile?.age.toString(),
                      ),
                      InformationTile(
                        icon: Icons.phone,
                        title: 'Số điện thoại',
                        subtitle: status == Status.loading
                            ? "Đang cập nhật"
                            : controller.user.value.profile?.phone,
                      ),
                      InformationTile(
                        icon: Icons.location_pin,
                        title: 'Địa chỉ',
                        subtitle: status == Status.loading
                            ? "Đang cập nhật"
                            : controller.user.value.profile?.address,
                      ),
                      GestureDetector(
                        onTap: () => controller.signOut(),
                        child: Container(
                          height: 50,
                          margin: EdgeInsets.symmetric(
                              horizontal: 60, vertical: 30),
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25),
                            color: kMainColor,
                          ),
                          child: Center(
                            child: Text(
                              "Đăng xuất".toUpperCase(),
                              style: GoogleFonts.openSans(
                                fontSize: 18,
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
