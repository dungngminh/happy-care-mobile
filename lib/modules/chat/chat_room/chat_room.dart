import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:happy_care/core/themes/colors.dart';
import 'package:happy_care/data/models/room_chat/room_chat_pass.dart';
import 'package:happy_care/modules/chat/chat_room/chat_room_controller.dart';
import 'package:happy_care/modules/chat/widget/not_own_messenger.dart';
import 'package:happy_care/modules/chat/widget/own_messenger.dart';

class ChatRoomScreen extends GetView<ChatRoomController> {
   ChatRoomScreen({Key? key}) : super(key: key);
  final roomPass = Get.arguments as RoomChatPass;
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Get.back(result: true);
        controller.leaveChatRoom(roomId: roomPass.id);
        return true;
      },
      child: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: kMainColor,
            titleSpacing: -10,
            title: ListTile(
              leading: CircleAvatar(
                backgroundColor: kSecondColor,
                child: Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: CircleAvatar(
                    backgroundColor: kMainColor,
                    backgroundImage: roomPass.userChatWith.profile?.avatar ==
                            null
                        ? Image.asset("assets/images/icon.png").image
                        : Image.network(roomPass.userChatWith.profile!.avatar!)
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
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Obx(
                  () {
                    final status = controller.status.value;
                    if (status == ChatRoomStatus.loading) {
                      return Center(
                          child: CircularProgressIndicator(
                        color: kMainColor,
                      ));
                    } else {
                      return ListView.builder(
                        reverse: true,
                        controller: controller.scrollController,
                        itemCount: controller.listMess.length + 1,
                        itemBuilder: (context, index) {
                          if (index == controller.listMess.length) {
                            return _buildProgressIndicator();
                          }
                          if (controller.listMess[index].user !=
                              roomPass.userChatWith.id) {
                            return OwnMessenger(
                                message: controller.listMess[index].content!,
                                time: controller.formater.format(
                                  DateTime.parse(
                                          controller.listMess[index].time!)
                                      .toLocal(),
                                ),
                                type: controller.listMess[index].type!);
                          } else {
                            return NotOwnMessenger(
                                message: controller.listMess[index].content!,
                                avatar: roomPass.userChatWith.profile?.avatar,
                                time: controller.formater.format(
                                  DateTime.parse(
                                    controller.listMess[index].time!,
                                  ).toLocal(),
                                ),
                                type: controller.listMess[index].type!);
                          }
                        },
                      );
                    }
                  },
                ),
              ),
              Obx(
                () => controller.isTyping.value
                    ? Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Text(
                            "${roomPass.userChatWith.profile?.fullname ?? roomPass.userChatWith.email} đang nhập..."),
                      )
                    : SizedBox(),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                    ),
                    padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                    child: Row(
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(left: 5.0),
                          child: IconButton(
                            icon: Icon(
                              Icons.image_rounded,
                              size: 25.0,
                              color: kMainColor,
                            ),
                            onPressed: () => controller.getImageToSend(),
                          ),
                        ),
                        controller.userController.user.value.role == "doctor"
                            ? IconButton(
                                icon: Icon(
                                  Icons.healing_rounded,
                                  size: 25.0,
                                  color: kMainColor,
                                ),
                                onPressed: () {
                                  showModalBottomSheet(
                                    context: context,
                                    isScrollControlled: true,
                                    backgroundColor: Colors.transparent,
                                    builder: (context) =>
                                        DraggableScrollableSheet(
                                      initialChildSize: 0.64,
                                      minChildSize: 0.25,
                                      maxChildSize: 1,
                                      builder: (context, scrollController) {
                                        return Container(
                                          color: Colors.white,
                                          child: Column(
                                            children: [
                                              Text("Đơn thuốc"),
                                            ],
                                          ),
                                        );
                                      },
                                    ),
                                  );
                                })
                            : SizedBox(),
                        Expanded(
                          child: TextField(
                            focusNode: controller.focusNode,
                            controller: controller.textMessController,
                            maxLines: null,
                            onChanged: (value) =>
                                controller.onTypingMessage(roomPass.id),
                            decoration: InputDecoration(
                              contentPadding:
                                  EdgeInsets.only(left: 5) + EdgeInsets.all(10),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(25),
                                borderSide: BorderSide(
                                  width: 0,
                                  style: BorderStyle.none,
                                ),
                              ),
                              hintText: 'Aa',
                              filled: true,
                              fillColor: Colors.grey.shade200,
                              hintStyle: GoogleFonts.openSans(
                                fontSize: 16.0,
                                fontWeight: FontWeight.w600,
                                color: Colors.grey[600],
                              ),
                              suffixIcon: IconButton(
                                onPressed: () {},
                                icon: Icon(
                                  Icons.emoji_emotions,
                                  size: 25.0,
                                  color: kMainColor,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 8.0),
                          child: Obx(
                            () => IconButton(
                              iconSize: 22,
                              onPressed: () => !controller.isHadImage.value
                                  ? controller.sendMessage(roomId: roomPass.id)
                                  : controller.sendImage(roomId: roomPass.id),
                              icon: controller.isSendingImage.value
                                  ? CircularProgressIndicator(
                                      color: kMainColor,
                                      strokeWidth: 2.0,
                                    )
                                  : Icon(
                                      !controller.isHadImage.value
                                          ? Icons.send_rounded
                                          : Icons.attach_file,
                                      size: 24.0,
                                      color: kMainColor,
                                    ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
              GetBuilder<ChatRoomController>(builder: (controller) {
                return controller.imageToSend == null
                    ? SizedBox()
                    : _buildImagePreview(controller);
              }),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildImagePreview(ChatRoomController controller) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 5.0),
      child: Container(
        color: Colors.white,
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Ảnh được chọn',
              style: GoogleFonts.openSans(
                color: Colors.grey.shade500,
                fontSize: 15,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.shade400,
                    offset: Offset(0, 0.5),
                    blurRadius: 3,
                    spreadRadius: 2,
                  )
                ],
              ),
              child: Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.file(
                      controller.imageToSend!,
                      width: 70,
                    ),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          controller.imageToSend!.path.split('/').last,
                          style: GoogleFonts.openSans(
                            fontSize: 14,
                            color: Colors.black,
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          '${(controller.imageToSend!.lengthSync() / 1024).ceil()} KB',
                          style: GoogleFonts.openSans(
                            fontSize: 13,
                            color: Colors.grey.shade600,
                          ),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    onPressed: () => controller.removeFile(),
                    icon: Icon(
                      Icons.close,
                      color: kMainColor,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProgressIndicator() {
    return controller.isMoreLoading.value
        ? Padding(
            padding: const EdgeInsets.all(2.0),
            child: Center(
              child: CircularProgressIndicator(
                color: kMainColor,
              ),
            ),
          )
        : SizedBox();
  }
}
