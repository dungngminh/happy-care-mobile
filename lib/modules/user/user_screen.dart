import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:happy_care/core/themes/colors.dart';
import 'package:happy_care/modules/user/user_controller.dart';
import 'package:happy_care/routes/app_pages.dart';
import 'package:happy_care/widgets/information_tile.dart';

class UserScreen extends GetView<UserController> {
  const UserScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: RefreshIndicator(
          color: kMainColor,
          onRefresh: () => controller.getUserInformation(),
          child: Stack(
            children: [
              ListView(),
              Column(
                children: [
                  Expanded(
                    flex: 5,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 30),
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
                              IconButton(
                                onPressed: () => Get.toNamed(AppRoutes.rEdit),
                                icon: Icon(
                                  Icons.edit,
                                  color: Colors.white,
                                  size: 26,
                                ),
                              ),
                            ],
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
                                      Image.asset("assets/images/icon.png")
                                          .image,
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
                                  : controller
                                          .user.value.profileUser?.fullName ??
                                      controller.user.value.email,
                              style: GoogleFonts.openSans(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                fontSize: controller
                                            .user.value.profileUser?.fullName !=
                                        null
                                    ? 24
                                    : 20,
                              ),
                            );
                          }),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 6,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20.0,
                        vertical: 10.0,
                      ),
                      child: Obx(() {
                        final status = controller.status.value;
                        return Column(
                          children: [
                            InformationTile(
                              icon: Icons.mail,
                              title: 'Email',
                              subtitle: status == Status.loading
                                  ? "Đang cập nhật"
                                  : controller.user.value.email,
                            ),
                            InformationTile(
                              icon: Icons.phone,
                              title: 'Số điện thoại',
                              subtitle: status == Status.loading
                                  ? "Đang cập nhật"
                                  : controller.user.value.profileUser?.phone,
                            ),
                            InformationTile(
                              icon: Icons.location_pin,
                              title: 'Địa chỉ',
                              subtitle: status == Status.loading
                                  ? "Đang cập nhật"
                                  : controller.user.value.profileUser?.address,
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
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
