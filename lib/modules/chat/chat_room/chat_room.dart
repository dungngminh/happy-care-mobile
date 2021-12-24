import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:happy_care/core/themes/colors.dart';
import 'package:happy_care/data/models/drug.dart';
import 'package:happy_care/data/models/room_chat/room_chat_pass.dart';
import 'package:happy_care/modules/chat/chat_room/chat_room_controller.dart';
import 'package:happy_care/modules/chat/widget/not_own_messenger.dart';
import 'package:happy_care/modules/chat/widget/own_messenger.dart';
import 'package:happy_care/widgets/custom_text_field.dart';
import 'package:sizer/sizer.dart';

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
                        ? Image.asset("assets/images/blank.png").image
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
          body: Stack(
            fit: StackFit.expand,
            children: [
              Column(
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
                                  type: controller.listMess[index].type!,
                                  functionWithId: () => controller
                                              .listMess[index].type! ==
                                          "prescription"
                                      ? controller.jumpToDetailPrescription(
                                          controller.listMess[index].content!)
                                      : null,
                                );
                              } else {
                                return NotOwnMessenger(
                                  message: controller.listMess[index].content!,
                                  avatar: roomPass.userChatWith.profile?.avatar,
                                  time: controller.formater.format(
                                    DateTime.parse(
                                      controller.listMess[index].time!,
                                    ).toLocal(),
                                  ),
                                  type: controller.listMess[index].type!,
                                  functionWithId: () => controller
                                              .listMess[index].type! ==
                                          "prescription"
                                      ? controller.jumpToDetailPrescription(
                                          controller.listMess[index].content!)
                                      : null,
                                );
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
                            padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
                            child: Text((controller
                                            .userController.user.value.role ==
                                        "member"
                                    ? "Bác sĩ "
                                    : "") +
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
                            controller.userController.user.value.role ==
                                    "doctor"
                                ? IconButton(
                                    icon: Icon(
                                      Icons.healing_rounded,
                                      size: 25.0,
                                      color: kMainColor,
                                    ),
                                    onPressed: () {
                                      controller.addNewDrug();
                                      _buildCreatePrescriptionBottomSheet(
                                              context)
                                          .whenComplete(() =>
                                              controller.resetBottomSheet());
                                    },
                                  )
                                : SizedBox(),
                            Expanded(
                              child: TextField(
                                focusNode: controller.focusNode,
                                controller: controller.textMessController,
                                maxLines: null,
                                onChanged: (value) => controller
                                    .onTypingMessage(roomPass.id, value),
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.only(left: 5) +
                                      EdgeInsets.all(10),
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
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 8.0),
                              child: Obx(
                                () => IconButton(
                                  iconSize: 22,
                                  onPressed: () => !controller.isHadImage.value
                                      ? controller.sendMessage(
                                          roomId: roomPass.id)
                                      : controller.sendImage(
                                          roomId: roomPass.id),
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
            ],
          ),
        ),
      ),
    );
  }

  Future<dynamic> _buildCreatePrescriptionBottomSheet(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Padding(
        padding: MediaQuery.of(context).viewInsets,
        child: DraggableScrollableSheet(
          initialChildSize: 0.85,
          minChildSize: 0.25,
          maxChildSize: 0.95,
          builder: (context, scrollController) {
            return GestureDetector(
              onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(25),
                    topRight: Radius.circular(25),
                  ),
                ),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15.0, vertical: 2),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Divider(
                        indent: 40.w,
                        endIndent: 40.w,
                        thickness: 4,
                        color: kMainColor,
                      ),
                      SizedBox(
                        height: 1.2.h,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Tạo đơn thuốc mới",
                              style: GoogleFonts.openSans(
                                color: kMainColor,
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            Obx(() => controller.listDrug.isNotEmpty
                                ? IconButton(
                                    icon: Icon(
                                      Icons.save_rounded,
                                      color: kMainColor,
                                    ),
                                    onPressed: () => controller
                                        .createNewPrescription(context),
                                  )
                                : SizedBox()),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 1.7.h,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10.0,
                        ),
                        child: CustomTextField(
                          controller: controller.diagnoseController,
                          icon: Icons.search_rounded,
                          labelText: "Chuẩn đoán",
                          hintText: "Nhập vào chuẩn đoán...",
                          // controller:
                          //     controller.ageController,
                        ),
                      ),
                      SizedBox(
                        height: 1.2.h,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10.0,
                        ),
                        child: CustomTextField(
                          controller: controller.noteController,
                          icon: Icons.search_rounded,
                          labelText: "Ghi chú (nếu có)",
                          hintText: "Nhập vào ghi chú...",
                        ),
                      ),
                      SizedBox(height: 0.5.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Thuốc",
                            style: GoogleFonts.openSans(
                              color: kMainColor,
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          IconButton(
                            padding: const EdgeInsets.only(),
                            onPressed: () {
                              controller.addNewDrug();
                              if (scrollController.hasClients) {
                                scrollController.animateTo(
                                  scrollController.position.maxScrollExtent,
                                  curve: Curves.easeOut,
                                  duration: Duration(milliseconds: 100),
                                );
                              }
                            },
                            icon: Icon(
                              Icons.add_rounded,
                              color: kMainColor,
                              size: 26,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 1.h,
                      ),
                      Obx(
                        () => Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 10.0),
                            child: ListView.separated(
                              controller: scrollController,
                              itemCount: controller.listDrug.length,
                              itemBuilder: (context, index) {
                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "Thuốc ${index + 1}",
                                          style: GoogleFonts.openSans(
                                              color: kMainColor,
                                              fontSize: 11.sp,
                                              fontWeight: FontWeight.w600),
                                        ),
                                        IconButton(
                                          padding: const EdgeInsets.only(),
                                          onPressed: () => controller
                                              .removeDrugAtIndex(index),
                                          icon: Icon(
                                            Icons.delete_rounded,
                                            color: kMainColor,
                                            size: 26,
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 1.2.h,
                                    ),
                                    DropdownButtonFormField<Drug>(
                                        isExpanded: true,
                                        items: controller
                                            .prescriptionController.drugList
                                            .map<DropdownMenuItem<Drug>>(
                                                (Drug drug) {
                                          return DropdownMenuItem<Drug>(
                                              child: Text(
                                                drug.name!,
                                                style: GoogleFonts.openSans(
                                                    color: kMainColor),
                                              ),
                                              value: drug);
                                        }).toList(),
                                        decoration: InputDecoration(
                                          prefixIcon: Icon(
                                              Icons.medication_rounded,
                                              color: kMainColor),
                                          enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color:
                                                  kMainColor.withOpacity(0.7),
                                            ),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: kMainColor,
                                            ),
                                          ),
                                          focusColor: kMainColor,
                                          border: OutlineInputBorder(),
                                          labelText: "Thuốc",
                                          hintText: "Chọn thuốc",
                                          labelStyle: GoogleFonts.openSans(
                                              color: kMainColor),
                                          hintStyle: GoogleFonts.openSans(
                                              color: kMainColor),
                                        ),
                                        onChanged: (Drug? drug) {
                                          controller.listDrug[index].drug =
                                              drug!.id!;
                                          print(
                                              controller.listDrug[index].drug);
                                        }),
                                    SizedBox(
                                      height: 1.h,
                                    ),
                                    CustomTextField(
                                      controller:
                                          controller.dosageControllers![index],
                                      icon: Icons.note_alt_rounded,
                                      labelText: "Mô tả liều dùng",
                                      hintText: "Nhập vào mô tả liều dùng...",
                                      onChangedFunction: (value) {
                                        controller.listDrug[index].dosage =
                                            value;
                                      },
                                    ),
                                  ],
                                );
                              },
                              separatorBuilder: (context, index) {
                                return SizedBox(
                                  height: 1.5.h,
                                );
                              },
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
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
