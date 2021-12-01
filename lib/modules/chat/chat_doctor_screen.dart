import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:happy_care/core/themes/colors.dart';
import 'package:happy_care/data/models/room_chat/room_chat_pass.dart';
import 'package:happy_care/modules/chat/chat_controller.dart';
import 'package:happy_care/modules/chat/widget/room_mess_list_tile.dart';
import 'package:happy_care/modules/user/user_controller.dart';
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
            padding: const EdgeInsets.only(left: 15, right: 5, top: 40),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      radius: 22,
                      backgroundColor: kMainColor,
                      child: Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: GetBuilder<UserController>(
                          builder: (controller) {
                            return controller.user.value.profile?.avatar == null
                                ? CircleAvatar(
                                    backgroundImage:
                                        Image.asset("assets/images/icon.png")
                                            .image,
                                  )
                                : CircleAvatar(
                                    backgroundImage: Image.memory(base64Decode(
                                            controller
                                                .user.value.profile!.avatar!))
                                        .image,
                                  );
                          },
                        ),
                      ),
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
                controller.listRoom.isEmpty
                    ? IconButton(
                        splashRadius: 26,
                        padding: const EdgeInsets.only(),
                        onPressed: () => controller.loadMyRooms(),
                        icon: Icon(Icons.refresh_rounded),
                        color: kMainColor,
                        iconSize: 26,
                      )
                    : SizedBox(),
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
            child: RefreshIndicator(
              color: kMainColor,
              onRefresh: () => controller.loadMyRooms(),
              child: Obx(
                () {
                  final status = controller.status.value;
                  if (status == ChatStatus.loading) {
                    return Center(
                      child: CircularProgressIndicator(
                        color: kMainColor,
                      ),
                    );
                  } else if (status == ChatStatus.error) {
                    return Center(
                      child: Column(
                        children: [
                          Icon(
                            Icons.error,
                            color: kMainColor,
                          ),
                          Text(
                            "Có lỗi xảy ra, vui lòng thử lại",
                            style: GoogleFonts.openSans(
                              color: kMainColor,
                            ),
                          ),
                        ],
                      ),
                    );
                  } else {
                    if (controller.listRoom.isEmpty) {
                      return Align(
                        child: Text(
                          "Bạn chưa có cuộc tư vấn nào",
                          style: GoogleFonts.openSans(
                            color: kMainColor,
                          ),
                        ),
                      );
                    } else {
                      return ListView(
                        padding: const EdgeInsets.only(),
                        children: [
                          AnimationLimiter(
                            child: ListView.builder(
                              padding: const EdgeInsets.only(),
                              shrinkWrap: true,
                              physics: ClampingScrollPhysics(),
                              itemCount: controller.listRoom.length,
                              itemBuilder: (context, index) {
                                print("Room id:" +
                                    controller.listRoom[index]!.id!);
                                return AnimationConfiguration.staggeredList(
                                  position: index,
                                  duration: const Duration(seconds: 1),
                                  child: SlideAnimation(
                                    verticalOffset: 50.0,
                                    child: FadeInAnimation(
                                      child: RoomMessListTile(
                                        function: () async {
                                          await controller
                                              .joinToChatRoom(
                                                  notUserId: controller
                                                      .listUserChatWithByRoom[
                                                          index]
                                                      .id)
                                              .then(
                                                (value) => Get.toNamed(
                                                  AppRoutes.rChatRoom,
                                                  arguments: RoomChatPass(
                                                      controller
                                                          .listRoom[index]!.id!,
                                                      controller
                                                              .listUserChatWithByRoom[
                                                          index]),
                                                ),
                                              );
                                        },
                                        title: controller
                                                .listUserChatWithByRoom[index]
                                                .profile
                                                ?.fullname ??
                                            (controller.userController.user
                                                        .value.role !=
                                                    'doctor'
                                                ? "Bác sĩ ${controller.listUserChatWithByRoom[index].profile?.fullname}"
                                                : "${controller.listUserChatWithByRoom[index].profile?.fullname}"),
                                        avatar: controller
                                            .listUserChatWithByRoom[index]
                                            .profile
                                            ?.avatar,
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      );
                    }
                  }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
