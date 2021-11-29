import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:happy_care/core/themes/colors.dart';
import 'package:happy_care/data/models/specialization.dart';
import 'package:happy_care/modules/chat/search/chat_search_controller.dart';
import 'package:happy_care/modules/chat/widget/doctor_search_tile.dart';
import 'package:happy_care/routes/app_pages.dart';

class ChatSearchScreen extends GetWidget<ChatSearchController> {
  const ChatSearchScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.only(top: 30.0),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5.0),
                child: Row(
                  children: [
                    IconButton(
                      splashRadius: 24,
                      color: kMainColor,
                      onPressed: () => Get.back(),
                      icon: Icon(
                        Icons.arrow_back,
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: GetBuilder<ChatSearchController>(
                          builder: (controller) {
                        return DropdownButton<Specialization>(
                          hint: Text("Chuyên khoa",
                              style: GoogleFonts.openSans(color: kMainColor)),
                          alignment: Alignment.centerLeft,
                          isExpanded: true,
                          underline: SizedBox(),
                          style: GoogleFonts.openSans(
                              fontSize: 16,
                              color: kMainColor,
                              fontWeight: FontWeight.bold),
                          value: controller.selected?.id == null
                              ? null
                              : controller.selected,
                          iconSize: 24,
                          elevation: 16,
                          onChanged: (Specialization? newValue) =>
                              controller.categorySelected(newValue!),
                          items: controller.listSpec
                              .map<DropdownMenuItem<Specialization>>(
                                  (Specialization value) {
                            return DropdownMenuItem<Specialization>(
                              value: value,
                              child: Text(
                                value.name,
                                style: GoogleFonts.openSans(
                                  color: kMainColor,
                                ),
                              ),
                            );
                          }).toList(),
                        );
                      }),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: GetBuilder<ChatSearchController>(builder: (controller) {
                  return ListView.builder(
                    itemCount: controller.listDoctor.length,
                    itemBuilder: (context, index) {
                      return DoctorSearchTile(
                        fullname:
                            controller.listDoctor[index].profile?.fullname,
                        specialization:
                            controller.listDoctor[index].specializations!.first,
                        isOnline: controller.listDoctor[index].isOnline,
                        avatar: controller.listDoctor[index].profile?.avatar,
                        function: () async {
                          await controller.chatController
                              .joinToChatRoom(
                                  doctorId: controller.listDoctor[index].id)
                              .then((value) => Get.toNamed(AppRoutes.rChatRoom,
                                  arguments: controller.listDoctor[index]));
                        },
                      );
                    },
                  );
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
