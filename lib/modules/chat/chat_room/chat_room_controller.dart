import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:happy_care/core/themes/colors.dart';
import 'package:happy_care/data/models/chat_mess.dart';
import 'package:happy_care/data/models/prescription/medicine.dart';
import 'package:happy_care/data/models/room_chat/room_chat_pass.dart';
import 'package:happy_care/data/repositories/mess_repository.dart';
import 'package:happy_care/data/services/socket_io_service.dart';
import 'package:happy_care/modules/main_screen/controller/image_controller.dart';
import 'package:happy_care/modules/prescription/prescription_controller.dart';
import 'package:happy_care/modules/user/user_controller.dart';
import 'package:happy_care/routes/app_pages.dart';
import 'package:happy_care/widgets/my_toast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';

enum ChatRoomStatus { loading, idle, error }

class ChatRoomController extends GetxController
    with SingleGetTickerProviderMixin {
  final SocketIOService? ioService;
  final MessRepository? messRepo;
  FocusNode focusNode = FocusNode();
  final ScrollController scrollController = ScrollController();
  final PrescriptionController prescriptionController = Get.find();
  late final AnimationController animationController;
  final status = ChatRoomStatus.idle.obs;
  final isMoreLoading = false.obs;
  final UserController userController = Get.find();
  final ImageController imageController = Get.find();
  final formater = DateFormat("HH:mm");
  final TextEditingController textMessController = TextEditingController();
  List<TextEditingController>? dosageControllers;
  TextEditingController? diagnoseController;
  TextEditingController? noteController;
  var listMess = RxList<ChatMess>([]);
  var listDrug = RxList<Medicine>([]);
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
    status(ChatRoomStatus.loading);
    await messRepo!.getMessageHistory(roomId: roomPass.id).then((value) {
      listMess(value);

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
    if (userController.user.value.role == "doctor") {
      dosageControllers = <TextEditingController>[];
      diagnoseController = TextEditingController();
      noteController = TextEditingController();
    }
    ioService!.socket!.on('receive-message', (data) {
      print(data);
      listMess.insert(0, ChatMess.fromMap(data));
      scrollToBottom();
    });

    ioService!.socket!.on('receive-typing-message', (data) {
      print(data);
      //TODO: add animation for container
      data['userId'] != null ? isTyping(true) : isTyping(false);
      print("isTyping ${isTyping.value}");
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
      ioService!.isTypingAction(
        roomId: roomId,
        userId: userController.user.value.id,
        isTyping: false,
      );
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
    textMessController.dispose();
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

  onTypingMessage(String roomId, String value) {
    print(userController.user.value.id);
    print(textMessController.text);
    if (value.isNotEmpty) {
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

  addNewDrug() {
    listDrug.add(Medicine());
    dosageControllers!.add(TextEditingController());
  }

  resetBottomSheet() {
    listDrug.clear();
    dosageControllers!.clear();
    diagnoseController!.text = "";
  }

  removeDrugAtIndex(int index) {
    listDrug.removeAt(index);
    dosageControllers!.removeAt(index);
  }

  createNewPrescription(BuildContext context) async {
    if (diagnoseController!.text.isEmpty) {
      MyToast.showErrorToast(context, "Chuẩn đoán không được để trống");
    } else if (listDrug
        .where((medicine) => medicine.drug == null)
        .toList()
        .isNotEmpty) {
      MyToast.showErrorToast(
          context, "Có một hoặc nhiều hơn một đơn chưa có loại thuốc");
    } else if (dosageControllers!
        .where((element) => element.text.isEmpty)
        .toList()
        .isNotEmpty) {
      MyToast.showErrorToast(
          context, "Có một hoặc nhiều hơn một đơn chưa có mô tả liều dùng");
    } else {
      try {
        showDialog(
            barrierDismissible: false,
            context: context,
            builder: (context) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(
                      color: kMainColor,
                    ),
                    SizedBox(
                      height: 1.2.h,
                    ),
                    Text("Đang tạo đơn thuốc...",
                        style: GoogleFonts.openSans(
                            color: Colors.white, fontWeight: FontWeight.w700)),
                  ],
                ),
              );
            });
        await prescriptionController
            .createNewPrescription(
                diagnose: diagnoseController!.text,
                memberId: roomPass.userChatWith.id,
                doctorId: userController.user.value.id,
                medicines: listDrug)
            .then((value) {
          Get.back();
          MyToast.showToast("Tạo đơn thuốc thành công");
          Get.back();
          listMess.insert(
            0,
            ChatMess(
              content: value,
              user: userController.user.value.id,
              type: "prescription",
              time: DateTime.now().toLocal().toString(),
            ),
          );
          ioService!.sendMessage(
              content: value,
              roomId: roomPass.id,
              contentType: "prescription",
              userId: userController.user.value.id);
          scrollToBottom();
        });
        await prescriptionController.getMyPresciptions();
      } catch (_) {
        MyToast.showErrorToast(
            context, "Tạo đơn thuốc không thành công, vui lòng thử lại");
        throw Exception();
      }
    }
  }

  jumpToDetailPrescription(String prescriptionId) {
    final prescription = prescriptionController.prescriptionList
        .firstWhere((element) => element.id!.contains(prescriptionId));
    Get.toNamed(AppRoutes.rDetailPrescription, arguments: prescription);
  }
}
