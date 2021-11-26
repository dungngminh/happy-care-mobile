import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:happy_care/core/themes/colors.dart';
import 'package:happy_care/modules/user/edit_information/edit_information_controller.dart';
// ignore: import_of_legacy_library_into_null_safe

class EditInformationScreen extends GetView<EditInformationController> {
  const EditInformationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: () async {
        final shouldPop = await controller.showConfirmDialog(context);
        return shouldPop;
      },
      child: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: Scaffold(
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 40),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        onPressed: () async {
                          final shouldPop =
                              await controller.showConfirmDialog(context);
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
                          fontSize: 20,
                          color: kMainColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      IconButton(
                        onPressed: () => controller.saveUserInformation(),
                        icon: Icon(
                          Icons.save,
                          color: kMainColor,
                          size: 26,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: size.height * 0.03,
                  ),
                  Stack(
                    children: [
                      SizedBox(
                        height: 160,
                        width: 160,
                        child: CircleAvatar(
                          backgroundColor: kMainColor,
                          child: SizedBox(
                            height: 150,
                            width: 150,
                            child: GetBuilder<EditInformationController>(
                                builder: (context) {
                              return controller.profileImage == null
                                  ? CircleAvatar(
                                      backgroundImage:
                                          Image.asset("assets/images/icon.png")
                                              .image,
                                    )
                                  : CircleAvatar(
                                      backgroundImage:
                                          FileImage(controller.profileImage!));
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
                                              fontSize: 16,
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
                                              fontSize: 16,
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
                                              fontSize: 16,
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
                    height: size.height * 0.06,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Column(
                      children: [
                        TextFormField(
                          readOnly: true,
                          initialValue: controller.user.email,
                          style: GoogleFonts.openSans(color: kMainColor),
                          textAlignVertical: TextAlignVertical.center,
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.mail, color: kMainColor),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: kMainColor.withOpacity(0.7),
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: kMainColor,
                              ),
                            ),
                            focusColor: kMainColor,
                            border: OutlineInputBorder(),
                            labelText: 'Email',
                            labelStyle: GoogleFonts.openSans(color: kMainColor),
                            hintText: 'Nhập email của bạn..',
                            hintStyle: GoogleFonts.openSans(color: kMainColor),
                          ),
                        ),
                        SizedBox(
                          height: size.height * 0.03,
                        ),
                        TextFormField(
                          autofocus: false,
                          controller: controller.nameController,
                          style: GoogleFonts.openSans(color: kMainColor),
                          textAlignVertical: TextAlignVertical.center,
                          
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.person, color: kMainColor),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: kMainColor.withOpacity(0.7),
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: kMainColor,
                              ),
                            ),
                            focusColor: kMainColor,
                            border: OutlineInputBorder(),
                            labelText: 'Tên',
                            labelStyle: GoogleFonts.openSans(color: kMainColor),
                            hintText: 'Nhập tên của bạn..',
                            hintStyle: GoogleFonts.openSans(color: kMainColor),
                          ),
                        ),
                        SizedBox(
                          height: size.height * 0.03,
                        ),
                        TextFormField(
                          autofocus: false,
                          controller: controller.ageController,
                          style: GoogleFonts.openSans(color: kMainColor),
                          textAlignVertical: TextAlignVertical.center,
    
                          decoration: InputDecoration(
                            prefixIcon:
                                Icon(Icons.badge_rounded, color: kMainColor),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: kMainColor.withOpacity(0.7),
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: kMainColor,
                              ),
                            ),
                            focusColor: kMainColor,
                            border: OutlineInputBorder(),
                            labelText: 'Tuổi',
                            labelStyle: GoogleFonts.openSans(color: kMainColor),
                            hintText: 'Nhập tuổi của bạn..',
                            hintStyle: GoogleFonts.openSans(color: kMainColor),
                          ),
                        ),
                        SizedBox(
                          height: size.height * 0.03,
                        ),
                        TextFormField(
                          autofocus: false,
                          controller: controller.phoneController,
                          style: GoogleFonts.openSans(color: kMainColor),
                          textAlignVertical: TextAlignVertical.center,
                  
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.phone, color: kMainColor),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: kMainColor.withOpacity(0.7),
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: kMainColor,
                              ),
                            ),
                            focusColor: kMainColor,
                            border: OutlineInputBorder(),
                            labelText: 'Số điện thoại',
                            labelStyle: GoogleFonts.openSans(color: kMainColor),
                            hintText: 'Nhập số điện thoại của bạn..',
                            hintStyle: GoogleFonts.openSans(color: kMainColor),
                          ),
                        ),
                        SizedBox(
                          height: size.height * 0.03,
                        ),
                        TextFormField(
                          
                          autofocus: false,
                          controller: controller.addressController,
                          style: GoogleFonts.openSans(color: kMainColor),
                          textAlignVertical: TextAlignVertical.center,
                        
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.person, color: kMainColor),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: kMainColor.withOpacity(0.7),
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: kMainColor,
                              ),
                            ),
                            
                            focusColor: kMainColor,
                            border: OutlineInputBorder(),
                            labelText: 'Địa chỉ',
                            labelStyle: GoogleFonts.openSans(color: kMainColor),
                            hintText: 'Nhập địa chỉ của bạn..',
                            hintStyle: GoogleFonts.openSans(color: kMainColor),
                          ),
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
