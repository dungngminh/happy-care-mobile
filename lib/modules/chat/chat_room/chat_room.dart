import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:happy_care/core/themes/colors.dart';
import 'package:happy_care/modules/chat/chat_room/chat_room_controller.dart';
import 'package:happy_care/modules/chat/widget/not_own_messenger.dart';
import 'package:happy_care/modules/chat/widget/own_messenger.dart';

class ChatRoomScreen extends GetView<ChatRoomController> {
  const ChatRoomScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return GestureDetector(
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
              backgroundImage: Image.asset("assets/images/icon.png").image,
            ),
            title: Text(
              "Nguyễn Minh Dũng",
              style: GoogleFonts.openSans(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 15,
              ),
            ),
            subtitle: Text(
              "Khoa Nam học",
              style: GoogleFonts.openSans(
                color: Colors.white,
                fontSize: 13,
              ),
            ),
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
          padding: EdgeInsets.only(bottom: 5),
          color: kSecondColor,
          child: ListView(
            shrinkWrap: true,
            reverse: true,
            //messenge = messenger.reversed.toList();
            children: const [
              NotOwnMessenger(
                messenge: 'Tôi có thể giúp gì cho bạn?',
                time: '18:02',
              ),
              OwnMessenger(
                messenge: 'Tôi có vấn đề về sức khỏe cần bạn giúp đỡ',
                time: '18:01',
              ),
              OwnMessenger(
                messenge: 'Anh bạn à',
                time: '18:01',
              ),
            ],
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
                      textAlignVertical: TextAlignVertical.center,
                    ),
                  ),
                  IconButton(
                    color: kMainColor,
                    onPressed: () {},
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
    );
  }
}
