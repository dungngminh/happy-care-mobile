import 'dart:async';
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

class ChatRoomController extends GetxController
    with SingleGetTickerProviderMixin {
  final SocketIOService? ioService;
  final MessRepository? messRepo;
  FocusNode focusNode = FocusNode();
  final ScrollController scrollController = ScrollController();
  late final AnimationController animationController;
  final Tween<Offset> tween = Tween(begin: Offset(0, 1), end: Offset(0, 0));
  final status = ChatRoomStatus.idle.obs;
  final isMoreLoading = false.obs;
  final UserController userController = Get.find();
  final ImageController imageController = Get.find();
  final formater = DateFormat("HH:mm");
  late TextEditingController textMessController;
  var listMess = RxList<ChatMess>([]);
  final isTyping = false.obs;
  final isHadImage = false.obs;
  final isSendingImage = false.obs;

  File? imageToSend;
  int lap = 10;
  final roomPass = Get.arguments as RoomChatPass;
  ChatRoomController({this.messRepo, this.ioService});

  @override
  Future<void> onInit() async {
    super.onInit();
    textMessController = TextEditingController();
    animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 500));

    status(ChatRoomStatus.loading);
    await messRepo!.getMessageHistory(roomId: roomPass.id).then((value) {
      listMess(value);
      // listMess.value = listMess.reversed.toList();
      status(ChatRoomStatus.idle);
    }).onError((error, stackTrace) {
      print(error);
      status(ChatRoomStatus.error);
    });
    scrollController.addListener(() async {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        await getMoreData(roomId: roomPass.id);
      }
    });

    ioService!.socket!.on('receive-message', (data) {
      print(data);
      listMess.insert(0, ChatMess.fromMap(data));
      scrollToBottom();
    });

    ioService!.socket!.on('receive-typing-message', (data) {
      print(data);
      data['userId'] != null ? isTyping(true) : isTyping(false);
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

  Future<void> getMoreData({required String roomId}) async {
    isMoreLoading(true);
    await messRepo!.getMessageHistory(roomId: roomId, start: lap).then((value) {
      isMoreLoading(false);
      listMess.addAll(value);
    }).onError((error, stackTrace) {
      isMoreLoading(false);
      print(stackTrace);
    });
    lap += 10;
  }

  void sendMessage({required String roomId}) {
    if (textMessController.text.trim() != "") {
      listMess.insert(
        0,
        ChatMess(
          content: textMessController.text.trim(),
          user: userController.user.value.id,
          type: "text",
          time: DateTime.now().toLocal().toString(),
        ),
      );
      ioService!.sendMessage(
          content: textMessController.text.trim(),
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
    isSendingImage(true);
    await imageController.myCloudinaryService
        .uploadFileOnCloudinary(filePath: imageToSend!.path)
        .then((imageUrl) {
      print(imageUrl);
      isSendingImage(false);
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

  onTypingMessage(String roomId) {
    print(textMessController.text);
    if (textMessController.text != "") {
      ioService!.isTypingAction(
          roomId: roomId, userId: userController.user.value.id, isTyping: true);
    } else {
      ioService!.isTypingAction(
        roomId: roomId,
        userId: userController.user.value.id,
        isTyping: false,
      );
    }
  }
}
