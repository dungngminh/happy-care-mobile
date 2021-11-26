import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:happy_care/core/themes/colors.dart';
import 'package:happy_care/modules/chat/chat_controller.dart';
import 'package:happy_care/modules/chat/widget/room_mess_list_tile.dart';
import 'package:happy_care/routes/app_pages.dart';

class ChatDoctorScreen extends GetWidget<ChatController> {
  const ChatDoctorScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 15, right: 15, top: 40),
            child: Row(
              children: [
                CircleAvatar(
                  backgroundImage: Image.asset("assets/images/icon.png").image,
                ),
                SizedBox(
                  width: size.width * 0.04,
                ),
                Text(
                  "Tư vấn sức khỏe",
                  style: GoogleFonts.openSans(
                      color: kMainColor,
                      fontSize: 22,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          SizedBox(
            height: size.height * 0.02,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Text(
              "Danh sách tư vấn",
              style: GoogleFonts.openSans(
                color: kMainColor,
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          SizedBox(
            height: size.height * 0.02,
          ),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.only(),
              children: [
                ListView.builder(
                  padding: const EdgeInsets.only(),
                  shrinkWrap: true,
                  physics: ClampingScrollPhysics(),
                  itemCount: 10,
                  itemBuilder: (context, index) {
                    return RoomMessListTile(
                      function: () => Get.toNamed(
                        AppRoutes.rChatRoom,
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildSearchBar({required void Function() function}) {
    return GestureDetector(
      onTap: function,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 15),
        padding: const EdgeInsets.only(
          left: 15,
          right: 30,
        ),
        height: 40,
        width: double.infinity,
        decoration: BoxDecoration(
          color: kSecondColor,
          borderRadius: BorderRadius.circular(25),
        ),
        child: Row(
          children: [
            Icon(
              Icons.search_rounded,
              color: kMainColor,
              size: 24,
            ),
            SizedBox(
              width: 10,
            ),
            Text(
              "Tìm kiếm",
              style: GoogleFonts.openSans(
                color: kMainColor,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
