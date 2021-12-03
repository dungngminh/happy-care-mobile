import 'dart:async';
import 'dart:collection';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:happy_care/data/models/chat_mess.dart';
import 'package:happy_care/data/models/room_chat/room_chat_pass.dart';
import 'package:happy_care/data/repositories/mess_repository.dart';
import 'package:happy_care/data/socket/socket_io_service.dart';
import 'package:happy_care/modules/user/user_controller.dart';
import 'package:intl/intl.dart';

enum ChatRoomStatus { loading, idle, error }

class ChatRoomController extends GetxController {
  final SocketIOService? ioService;
  final MessRepository? messRepo;
  FocusNode focusNode = FocusNode();
  final ScrollController scrollController = ScrollController();
  final status = ChatRoomStatus.idle.obs;
  final UserController userController = Get.find();
  final formater = DateFormat("HH:mm");
  late TextEditingController textMessController;
  var listMess = RxList<ChatMess>([]);
  var isTyping = false.obs;

  ChatRoomController({this.messRepo, this.ioService});

  @override
  Future<void> onInit() async {
    super.onInit();
    textMessController = TextEditingController();
    final roomPass = Get.arguments as RoomChatPass;
    status(ChatRoomStatus.loading);
    await messRepo!.getMessageHistory(roomId: roomPass.id).then((value) {
      listMess(value);
      // listMess.value = listMess.reversed.toList();
      status(ChatRoomStatus.idle);
    }).onError((error, stackTrace) {
      print(error);
      status(ChatRoomStatus.error);
    });
    scrollController.addListener(() {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        //TODO : add more mess
      }
    });
    scrollToBottom();
    ioService!.socket.on('receive-message', (data) async {
      print(data);
      listMess.insert(0, ChatMess.fromMap2(data));
      scrollToBottom();
    });
  }

  scrollToBottom() {
    if (scrollController.hasClients) {
      scrollController.animateTo(
        0.0,
        curve: Curves.easeOut,
        duration: Duration(milliseconds: 100),
      );
    }
  }

  sendMessage({required String roomId}) async {
    listMess.insert(
      0,
      ChatMess(
        content: textMessController.text,
        user: userController.user.value.id,
        time: DateTime.now().toLocal().toString(),
      ),
    );
    ioService!.sendMessage(
        content: textMessController.text,
        roomId: roomId,
        userId: userController.user.value.id);
    scrollToBottom();
    textMessController.clear();
    focusNode.requestFocus();
  }

  leaveChatRoom({required String roomId}) {
    ioService!.leaveChatRoom(roomId: roomId);
    return true;
  }

  @override
  void onClose() {
    scrollController.dispose();
    super.onClose();
  }
}
