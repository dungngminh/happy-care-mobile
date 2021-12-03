import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:happy_care/data/models/chat_mess.dart';
import 'package:happy_care/data/models/room_chat/room_chat_pass.dart';
import 'package:happy_care/data/repositories/mess_repository.dart';
import 'package:happy_care/data/socket/socket_io_service.dart';
import 'package:happy_care/modules/user/user_controller.dart';
import 'package:intl/intl.dart';
import 'package:file_picker/file_picker.dart';

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
  var isHadImage = false.obs;
  File? imageToSend;
  PlatformFile? platformFile;

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

    ioService!.socket.on('receive-message', (data) async {
      print(data);
      listMess.insert(0, ChatMess.fromMap(data));
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

  void sendMessage({required String roomId}) {
    if (textMessController.text != "") {
      listMess.insert(
        0,
        ChatMess(
          content: textMessController.text,
          user: userController.user.value.id,
          type: "text",
          time: DateTime.now().toLocal().toString(),
        ),
      );
      ioService!.sendMessage(
          content: textMessController.text,
          roomId: roomId,
          contentType: "text",
          userId: userController.user.value.id);
      scrollToBottom();
      textMessController.clear();
      focusNode.requestFocus();
    }
  }

  leaveChatRoom({required String roomId}) {
    ioService!.leaveChatRoom(roomId: roomId);
    return true;
  }

  Future<void> getImageToSend() async {
    final _file = await FilePicker.platform.pickFiles(
        type: FileType.custom, allowedExtensions: ['png', 'jpg', 'jpeg']);

    if (_file != null) {
      imageToSend = File(_file.files.single.path!);
      platformFile = _file.files.first;
      isHadImage(true);
      update();
    }
  }

  removeFile() {
    imageToSend = null;
    platformFile = null;
    isHadImage(false);
    update();
  }

  @override
  void onClose() {
    scrollController.dispose();
    super.onClose();
  }

  sendImage({required String roomId}) async {
    final bytes = await imageToSend!.readAsBytes();
    listMess.insert(
      0,
      ChatMess(
        content: base64Encode(bytes),
        user: userController.user.value.id,
        type: "image",
        time: DateTime.now().toLocal().toString(),
      ),
    );
    ioService!.sendMessage(
        content: bytes,
        roomId: roomId,
        contentType: "image",
        userId: userController.user.value.id);
    scrollToBottom();
  }
}
