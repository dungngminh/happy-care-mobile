import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:happy_care/core/themes/colors.dart';
import 'package:happy_care/modules/user/edit_information/edit_information_controller.dart';
import 'package:happy_care/widgets/custom_text_field.dart';
import 'package:sizer/sizer.dart';

class EditInformationScreen extends GetView<EditInformationController> {
  const EditInformationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        final shouldPop = await controller.showConfirmDialog(context,
            title: "Hủy thay đổi",
            contentDialog: "Bạn có muốn hủy thay đổi?",
            confirmFunction: () => Get.back(result: true));
        return shouldPop;
      },
      child: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: Scaffold(
          body: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 2.5.w, vertical: 5.h),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        onPressed: () async {
                          final shouldPop = await controller.showConfirmDialog(
                              context,
                              title: "Hủy thay đổi",
                              contentDialog: "Bạn có muốn hủy thay đổi?",
                              confirmFunction: () => Get.back(result: true));

                          if (shouldPop) Get.back();
                        },
                        icon: Icon(
                          Icons.arrow_back_rounded,
                          color: kMainColor,
                          size: 26,
                        ),
                      ),
                      Text(
                        'Chỉnh sửa thông tin',
                        style: GoogleFonts.openSans(
                          fontSize: 15.sp,
                          color: kMainColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      IconButton(
                        onPressed: () =>
                            controller.saveUserInformation(context),
                        icon: Icon(
                          Icons.save,
                          color: kMainColor,
                          size: 26,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 2.h,
                  ),
                  Stack(
                    children: [
                      SizedBox(
                        height: 20.h,
                        width: 20.h,
                        child: CircleAvatar(
                          backgroundColor: kMainColor,
                          child: SizedBox(
                            height: 19.h,
                            width: 19.h,
                            child: GetBuilder<EditInformationController>(
                                builder: (controller) {
                              if (controller.profileImage == null) {
                                return controller.user.profile?.avatar != null
                                    ? CircleAvatar(
                                        backgroundImage:
                                            CachedNetworkImageProvider(
                                        controller.user.profile!.avatar!,
                                      ))
                                    : CircleAvatar(
                                        backgroundImage: Image.asset(
                                                "assets/images/icon.png")
                                            .image);
                              } else {
                                return CircleAvatar(
                                  backgroundImage:
                                      FileImage(controller.profileImage!),
                                );
                              }
                            }),
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: GestureDetector(
                          onTap: () {
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    content: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        ListTile(
                                          onTap: () => controller
                                              .getProfileImageFromCamera(),
                                          leading: Icon(Icons.photo_camera,
                                              color: kMainColor),
                                          title: Text(
                                            "Chụp ảnh",
                                            style: GoogleFonts.openSans(
                                              color: kMainColor,
                                              fontWeight: FontWeight.w600,
                                              fontSize: 14.sp,
                                            ),
                                          ),
                                        ),
                                        ListTile(
                                          onTap: () => controller
                                              .getProfileImageFromGallery(),
                                          leading: Icon(Icons.photo_album,
                                              color: kMainColor),
                                          title: Text(
                                            "Chọn từ thư viện",
                                            style: GoogleFonts.openSans(
                                              color: kMainColor,
                                              fontWeight: FontWeight.w600,
                                              fontSize: 14.sp,
                                            ),
                                          ),
                                        ),
                                        ListTile(
                                          onTap: () =>
                                              controller.removeProfileImage(),
                                          leading: Icon(Icons.delete,
                                              color: kMainColor),
                                          title: Text(
                                            "Xóa ảnh",
                                            style: GoogleFonts.openSans(
                                              color: kMainColor,
                                              fontWeight: FontWeight.w600,
                                              fontSize: 14.sp,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                });
                          },
                          child: CircleAvatar(
                            backgroundColor: kMainColor,
                            child: Icon(
                              Icons.add_a_photo,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 5.h,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Column(
                      children: [
                        CustomTextField(
                          initialValue: controller.user.email,
                          icon: Icons.mail,
                          canReadOnly: true,
                          labelText: "Email (không được thay đổi)",
                        ),
                        SizedBox(
                          height: 3.h,
                        ),
                        CustomTextField(
                          icon: Icons.person_rounded,
                          labelText: "Tên",
                          hintText: "Nhập vào tên của bạn...",
                          controller: controller.nameController,
                        ),
                        SizedBox(
                          height: 3.h,
                        ),
                        CustomTextField(
                          icon: Icons.badge_rounded,
                          labelText: "Tuổi",
                          hintText: "Nhập vào tuổi của bạn...",
                          controller: controller.ageController,
                          keyboardType: TextInputType.number,
                        ),
                        SizedBox(
                          height: 3.h,
                        ),
                        CustomTextField(
                          icon: Icons.phone,
                          labelText: "Số điện thoại",
                          hintText: "Nhập vào số điện thoại của bạn...",
                          keyboardType: TextInputType.phone,
                          controller: controller.phoneController,
                        ),
                        SizedBox(
                          height: 3.h,
                        ),
                        CustomTextField(
                          icon: Icons.place_rounded,
                          labelText: "Địa chỉ",
                          hintText: "Nhập vào địa chỉ của bạn...",
                          controller: controller.addressController,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
