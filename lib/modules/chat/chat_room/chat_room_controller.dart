import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:happy_care/data/models/chat_mess.dart';
import 'package:happy_care/data/models/room_chat/room_chat_pass.dart';
import 'package:happy_care/data/repositories/mess_repository.dart';
import 'package:happy_care/data/services/socket_io_service.dart';
import 'package:happy_care/modules/main_screen/controller/image_controller.dart';
import 'package:happy_care/modules/user/user_controller.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

enum ChatRoomStatus { loading, idle, error }

class ChatRoomController extends GetxController {
  final SocketIOService? ioService;
  final MessRepository? messRepo;
  FocusNode focusNode = FocusNode();
  final ScrollController scrollController = ScrollController();
  final status = ChatRoomStatus.idle.obs;
  final UserController userController = Get.find();
  final ImageController imageController = Get.find();
  final formater = DateFormat("HH:mm");
  late TextEditingController textMessController;
  var listMess = RxList<ChatMess>([]);
  var isTyping = false.obs;
  var isHadImage = false.obs;
  File? imageToSend;

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
    final _picker = ImagePicker();
    final _pickedFile = await _picker.pickImage(source: ImageSource.gallery);

    if (_pickedFile != null) {
      imageToSend = File(_pickedFile.path);
      isHadImage(true);
      update();
    }
  }

  removeFile() {
    imageToSend = null;
    isHadImage(false);
    update();
  }

  @override
  void onClose() {
    scrollController.dispose();
    super.onClose();
  }

  Future<void> sendImage({required String roomId}) async {
    await imageController.myCloudinaryService
        .uploadFileOnCloudinary(filePath: imageToSend!.path)
        .then((imageUrl) {
      print(imageUrl);
      listMess.insert(
        0,
        ChatMess(
          content: imageUrl,
          user: userController.user.value.id,
          type: "image",
          time: DateTime.now().toLocal().toString(),
        ),
      );
      ioService!.sendMessage(
          content: imageUrl,
          roomId: roomId,
          contentType: "image",
          userId: userController.user.value.id);
    });
    removeFile();
    scrollToBottom();
  }
}
