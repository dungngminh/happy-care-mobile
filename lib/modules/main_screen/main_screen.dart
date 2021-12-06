import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:happy_care/core/themes/colors.dart';
import 'package:happy_care/modules/chat/chat_doctor_screen.dart';
import 'package:happy_care/modules/chat/chat_screen.dart';
import 'package:happy_care/modules/home/home_doctor_screen.dart';
import 'package:happy_care/modules/home/home_screen.dart';
import 'package:happy_care/modules/main_screen/controller/main_controller.dart';
import 'package:happy_care/modules/prescription/prescription.dart';
import 'package:happy_care/modules/user/user_screen.dart';
import 'package:happy_care/modules/user/user_screen_doctor.dart';
import 'package:sizer/sizer.dart';

class MainScreen extends GetWidget<MainController> {
  const MainScreen({Key? key}) : super(key: key);

  final memberRole = const <Widget>[
    HomeScreen(),
    ChatScreen(),
    PrescriptionScreen(),
    UserScreen(),
  ];
  final doctorRole = const <Widget>[
    HomeDoctorScreen(),
    ChatDoctorScreen(),
    PrescriptionScreen(),
    UserDoctorScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        final mainStatus = controller.status.value;

        return mainStatus == MainStatus.loading
            ? Center(
                child: CircularProgressIndicator(
                  color: kMainColor,
                ),
              )
            : IndexedStack(
                index: controller.currentIndex.value,
                children:
                    controller.role.value == "doctor" ? doctorRole : memberRole,
              );
      }),
      bottomNavigationBar: Obx(
        () => BottomNavyBar(
          showElevation: false,
          selectedIndex: controller.currentIndex.value,
          items: [
            BottomNavyBarItem(
              icon: Icon(Icons.home_rounded),
              title: Text(
                'Trang chủ',
                style: GoogleFonts.openSans(
                  fontSize: 10.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              textAlign: TextAlign.center,
              activeColor: kMainColor,
              inactiveColor: kUnselectedIconColor,
            ),
            BottomNavyBarItem(
              icon: Icon(Icons.message),
              title: Text(
                'Trò chuyện',
                style: GoogleFonts.openSans(
                  fontSize: 10.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              activeColor: kMainColor,
              textAlign: TextAlign.center,
              inactiveColor: kUnselectedIconColor,
            ),
            BottomNavyBarItem(
              icon: Icon(Icons.healing),
              title: Text(
                'Đơn thuốc',
                style: GoogleFonts.openSans(
                  fontSize: 10.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              activeColor: kMainColor,
              textAlign: TextAlign.center,
              inactiveColor: kUnselectedIconColor,
            ),
            BottomNavyBarItem(
              icon: Icon(Icons.person),
              title: Text(
                'Cá nhân',
                style: GoogleFonts.openSans(
                  fontSize: 10.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              textAlign: TextAlign.center,
              activeColor: kMainColor,
              inactiveColor: kUnselectedIconColor,
            ),
          ],
          onItemSelected: (newIndex) => controller.changeCurrentIndex(newIndex),
        ),
      ),
    );
  }
}
