import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:happy_care/core/themes/colors.dart';
import 'package:happy_care/data/models/user.dart';
import 'package:happy_care/modules/user/user_controller.dart';
import 'package:happy_care/widgets/my_toast.dart';
import 'package:image_picker/image_picker.dart';

class EditInformationController extends GetxController {
  final UserController _userController = Get.find();
  User get user => _userController.user.value;
  File? profileImage;

  late TextEditingController nameController;
  late TextEditingController ageController;
  late TextEditingController phoneController;
  late TextEditingController addressController;

  @override
  void onInit() {
    super.onInit();
    nameController = TextEditingController(text: user.profile?.fullname);
    phoneController = TextEditingController(text: user.profile?.phone);
    ageController = TextEditingController(
        text: user.profile?.age != null ? user.profile!.age!.toString() : null);
     addressController = TextEditingController(text: user.profile?.address);
  }

  void onChangeValue(String value, String? field) {
    field = value;
  }

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

  saveUserInformation() async {
    bool result = await _userController.userRepository!.updateInformation(
      fullname: nameController.text == "" ? null : nameController.text,
      age: ageController.text == "" ? null : int.parse(ageController.text),
      phone: phoneController.text == "" ? null : phoneController.text,
      address: addressController.text == "" ? null : addressController.text,
    );

    if (result) {
      MyToast.showToast("Cập nhật thông tin thành công");
      Get.back(result: true);
    } else {
      MyToast.showToast("Cập nhật không thành công, vui lòng thử lại");
    }
  }
}
