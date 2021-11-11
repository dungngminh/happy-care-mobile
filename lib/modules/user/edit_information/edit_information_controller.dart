import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:happy_care/core/themes/colors.dart';
import 'package:happy_care/data/models/user.dart';
import 'package:happy_care/modules/user/user_controller.dart';
import 'package:image_picker/image_picker.dart';

class EditInformationController extends GetxController {
  final UserController _userController = Get.find();
  User get user => _userController.user.value;
  File? profileImage;

  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController addressController = TextEditingController();


  Future<bool> showConfirmDialog(context) async {
    return await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          "Hủy thay đổi",
          style: GoogleFonts.openSans(fontWeight: FontWeight.w600),
        ),
        content: Text(
          "Bạn xác nhận hủy thay đổi?",
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(result: true),
            child: Text(
              "Xác nhận",
              style: GoogleFonts.openSans(color: kMainColor),
            ),
          ),
          TextButton(
            onPressed: () => Get.back(result: false),
            child: Text(
              "Không",
              style: GoogleFonts.openSans(color: kMainColor),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> getProfileImageFromCamera() async {
    final _picker = ImagePicker();
    final _pickedFile = await _picker.pickImage(source: ImageSource.camera);
    if (_pickedFile != null) {
      profileImage = File(_pickedFile.path);
    } else {
      printError(info: "No image picked");
    }
    update();
    Get.back();
  }

  Future<void> getProfileImageFromGallery() async {
    final _picker = ImagePicker();
    final _pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (_pickedFile != null) {
      profileImage = File(_pickedFile.path);
    } else {
      printError(info: "No image picked");
    }
    update();
    Get.back();
  }

  void removeProfileImage() {
    profileImage = null;
    update();
    Get.back();
  }
}
