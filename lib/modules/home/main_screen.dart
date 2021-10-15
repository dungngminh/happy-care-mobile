import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:happy_care/core/themes/colors.dart';
import 'package:happy_care/modules/home/main_controller.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MainController>(builder: (controller) {
      return Scaffold(
        body: IndexedStack(
          index: controller.currentIndex,
          children: [

          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: controller.currentIndex,
          onTap: (newIndex) => controller.changeCurrentIndex(newIndex),
          selectedItemColor: kMainColor,
          unselectedItemColor: kUnselectedIconColor,
          selectedFontSize: 12,
          selectedLabelStyle: GoogleFonts.openSans(
            fontWeight: FontWeight.bold,
          ),
          type: BottomNavigationBarType.shifting,
          items: const [
            BottomNavigationBarItem(
                icon: Icon(Icons.home_rounded), label: 'Trang chủ'),
            BottomNavigationBarItem(
                icon: Icon(Icons.comment), label: 'Trò chuyện'),
            BottomNavigationBarItem(
                icon: Icon(Icons.healing), label: 'Đơn thuốc'),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Cá nhân'),
          ],
        ),
      );
    });
  }
}
