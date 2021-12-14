import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:happy_care/core/themes/colors.dart';
import 'package:happy_care/data/models/room_chat/room_chat_pass.dart';
import 'package:happy_care/data/models/specialization.dart';
import 'package:happy_care/modules/chat/doctor_detail/doctor_detail_screen.dart';
import 'package:happy_care/modules/chat/search/search_controller.dart';
import 'package:happy_care/modules/chat/widget/doctor_search_tile.dart';
import 'package:happy_care/routes/app_pages.dart';

class SearchScreen extends GetWidget<SearchController> {
  const SearchScreen({Key? key}) : super(key: key);

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
                      child:
                          GetBuilder<SearchController>(builder: (controller) {
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
                child: GetBuilder<SearchController>(builder: (controller) {
                  final status = controller.status.value;
                  if (status == SearchStatus.loading) {
                    return Center(
                      child: CircularProgressIndicator(
                        color: kMainColor,
                      ),
                    );
                  } else if (status == SearchStatus.error) {
                    return Center(
                      child: Column(
                        children: const [
                          Icon(
                            Icons.error,
                            color: kMainColor,
                          ),
                          Text("Có lỗi xảy ra! Vui lòng thử lại")
                        ],
                      ),
                    );
                  }
                  return ListView.builder(
                    itemCount: controller.listDoctor.length,
                    itemBuilder: (context, index) {
                      return DoctorSearchTile(
                        fullname:
                            controller.listDoctor[index].profile?.fullname,
                        specialization:
                            controller.listDoctor[index].specializations!.first,
                        status: controller.listDoctor[index].status,
                        avatar: controller.listDoctor[index].profile?.avatar,
                        function: () => Get.to(() => DoctorDetailScreen(
                              doctor: controller.listDoctor[index],
                              function: () async {
                                await controller.chatController
                                    .joinFirstToChatRoom(
                                        notUserId:
                                            controller.listDoctor[index].id)
                                    .then((value) => Get.toNamed(
                                        AppRoutes.rChatRoom,
                                        arguments: RoomChatPass(value!,
                                            controller.listDoctor[index])));
                              },
                            )),
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
