import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:happy_care/core/themes/colors.dart';
import 'package:happy_care/data/models/room_chat/room_chat_pass.dart';
import 'package:happy_care/modules/chat/chat_room/chat_room_controller.dart';
import 'package:happy_care/modules/chat/widget/not_own_messenger.dart';
import 'package:happy_care/modules/chat/widget/own_messenger.dart';
import 'package:intl/intl.dart';

class ChatRoomScreen extends GetWidget<ChatRoomController> {
  const ChatRoomScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final roomPass = Get.arguments as RoomChatPass;
    final size = MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: ()  => controller.leaveChatRoom(roomId: roomPass.id),
      child: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: kMainColor,
            leading: IconButton(
              splashRadius: 24,
              icon: BackButtonIcon(),
              onPressed: () => Get.back(),
            ),
            titleSpacing: -10,
            title: ListTile(
              leading: CircleAvatar(
                backgroundColor: kSecondColor,
                child: Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: CircleAvatar(
                    backgroundImage: roomPass.userChatWith.profile?.avatar == null
                        ? Image.asset("assets/images/icon.png").image
                        : Image.memory(base64Decode(
                                roomPass.userChatWith.profile!.avatar!))
                            .image,
                  ),
                ),
              ),
              title: Text(
                roomPass.userChatWith.profile?.fullname ??
                    roomPass.userChatWith.email,
                style: GoogleFonts.openSans(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                ),
              ),
              subtitle: roomPass.userChatWith.role != "member"
                  ? Text(
                      roomPass.userChatWith.specializations!.first,
                      style: GoogleFonts.openSans(
                        color: Colors.white,
                        fontSize: 13,
                      ),
                    )
                  : null,
            ),
            actions: [
              IconButton(
                onPressed: () {},
                splashRadius: 24,
                icon: Icon(
                  Icons.call_rounded,
                  color: Colors.white,
                ),
              ),
              IconButton(
                onPressed: () {},
                splashRadius: 24,
                icon: Icon(
                  Icons.video_call_rounded,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          body: Container(
            height: double.infinity,
            padding: EdgeInsets.only(bottom: 5, top: 5),
            color: kSecondColor,
            child: Obx(
              () {
                return ListView.builder(
                  shrinkWrap: true,
                  itemCount: controller.listMess.length,
                  itemBuilder: (context, index) {
                    final formater = DateFormat("HH:mm");
                    print(controller.listMess[index].user);
                    print("userchatwithId" + roomPass.userChatWith.id);
                    if (controller.listMess[index].user !=
                        roomPass.userChatWith.id) {
                      return OwnMessenger(
                        messenge: controller.listMess[index].content,
                        time: formater.format(
                          DateTime.now().toLocal(),
                        ),
                      );
                    } else {
                      return NotOwnMessenger(
                        messenge: controller.listMess[index].content,
                        avatar: roomPass.userChatWith.profile?.avatar,
                        time: formater.format(
                          DateTime.parse(
                            controller.listMess[index].time!,
                          ).toLocal(),
                        ),
                      );
                    }
                  },
                );
              },
            ),
          ),
          bottomNavigationBar: Transform.translate(
            offset: Offset(0.0, -1 * MediaQuery.of(context).viewInsets.bottom),
            child: BottomAppBar(
              child: Container(
                height: size.height * 0.06,
                padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                child: Row(
                  children: [
                    IconButton(
                      color: kMainColor,
                      onPressed: () {},
                      icon: Icon(
                        Icons.image_rounded,
                      ),
                    ),
                    Expanded(
                      child: TextField(
                        controller: controller.textMessController,
                        textAlignVertical: TextAlignVertical.center,
                      ),
                    ),
                    IconButton(
                      color: kMainColor,
                      onPressed: () =>
                          controller.sendMessage(roomId: roomPass.id),
                      icon: Icon(
                        Icons.send_rounded,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
