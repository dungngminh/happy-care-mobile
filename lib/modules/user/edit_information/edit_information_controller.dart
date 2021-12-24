import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:happy_care/core/helpers/show_custom_dialog.dart';

import 'package:happy_care/data/models/user.dart';
import 'package:happy_care/modules/main_screen/controller/image_controller.dart';
import 'package:happy_care/modules/user/user_controller.dart';
import 'package:happy_care/widgets/my_toast.dart';
import 'package:image_picker/image_picker.dart';

class EditInformationController extends GetxController {
  final UserController _userController = Get.find();
  final ImageController _imageController = Get.find();
  User get user => _userController.user.value;
  File? profileImage;
  late TextEditingController nameController;
  late TextEditingController ageController;
  late TextEditingController phoneController;
  late TextEditingController addressController;

  @override
  Future<void> onInit() async {
    super.onInit();
    nameController = TextEditingController(text: user.profile?.fullname);
    phoneController = TextEditingController(text: user.profile?.phone);
    ageController = TextEditingController(
        text: user.profile?.age != null ? user.profile!.age!.toString() : null);
    addressController = TextEditingController(text: user.profile?.address);
    update();
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

  saveUserInformation(BuildContext context) async {
    await showConfirmDialog(context,
        title: "Cập nhật thông tin",
        contentDialog: "Xác nhận cập nhật thông tin",
        confirmFunction: () async {
      showLoadingDialog(context, contentDialog: "Đang cập nhật thông tin...");
      String? url = profileImage != null
          ? await _imageController.myCloudinaryService
              .uploadFileOnCloudinary(filePath: profileImage!.path)
          : user.profile?.avatar;
      bool result = await _userController.userRepository!.updateInformation(
        fullname: nameController.text == "" ? null : nameController.text,
        age: ageController.text == "" ? null : int.parse(ageController.text),
        phone: phoneController.text == "" ? null : phoneController.text,
        address: addressController.text == "" ? null : addressController.text,
        avatar: url,
      );

      if (result) {
        Get.back();
        Get.back();
        MyToast.showToast("Cập nhật thông tin thành công");
        Get.back(result: true);
      } else {
        Get.back();
        Get.back();
        MyToast.showToast("Cập nhật không thành công, vui lòng thử lại");
      }
    });
  }
}
