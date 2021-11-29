import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:happy_care/data/models/chat_mess.dart';
import 'package:happy_care/data/socket/socket_io_service.dart';
import 'package:happy_care/modules/user/user_controller.dart';

class ChatRoomController extends GetxController {
  final SocketIOService? ioService;
  final UserController userController = Get.find();

  late TextEditingController textMessController;
  final listMess = RxList<ChatMess>([]);

  ChatRoomController({this.ioService});

  @override
  void onInit() {
    super.onInit();
    textMessController = TextEditingController();
    ioService!.socket.on('receive-message', (data) {
      print(data);
      listMess.add(ChatMess.fromJson(data));
    });
  }

  sendMessage({required String roomId}) {
    print("send");
    ioService!.sendMessage(
        content: textMessController.text,
        roomId: roomId,
        userId: userController.user.value.id);
    listMess.add(ChatMess(
        content: textMessController.text, user: userController.user.value.id));
    textMessController.clear();
  }

  @override
  void onClose() {
    textMessController.dispose();
    super.onClose();
  }
}
