import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:happy_care/core/themes/colors.dart';
import 'package:happy_care/data/repositories/user_repository.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

enum Status { loading, success, error }

class SignUpController extends GetxController {
  //obs variable
  final isHidePassword = true.obs;
  final isHideRepassword = true.obs;
  final status = Status.loading.obs;
  File? profileImage;

  //controller
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController rePasswordController = TextEditingController();
  final RoundedLoadingButtonController btnController =
      RoundedLoadingButtonController();

  //repository
  final UserRepository repository = UserRepository();

  void turnOnOffHiddenPassword() {
    isHidePassword.value = !isHidePassword.value;
    update();
  }

  void turnOnOffHiddenRepassword() {
    isHideRepassword.value = !isHideRepassword.value;
    update();
  }

  Future<void> createNewUser(BuildContext context) async {
    if (emailController.text.isEmpty ||
        passwordController.text.isEmpty ||
        rePasswordController.text.isEmpty) {
      btnController.error();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: kBackgroundColor,
          content: Text(
            "Vui lòng điền đủ thông tin",
            style: GoogleFonts.openSans(
              color: kMainColor,
              fontSize: 15,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      );
      await Future.delayed(Duration(seconds: 2))
          .then((value) => btnController.reset());
    } else {
      print(emailController.text);
      print(passwordController.text);
      bool isOK = await repository.createNewUser(
          email: emailController.text, password: passwordController.text);
      if (isOK) {
        btnController.success();
        await Future.delayed(Duration(seconds: 1)).then((value) => Get.back());
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: kBackgroundColor,
            content: Text(
              "Đăng ký thành công",
              style: GoogleFonts.openSans(
                color: kMainColor,
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        );
      } else {
        btnController.error();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: kBackgroundColor,
            content: Text(
              "Đăng ký thất bại",
              style: GoogleFonts.openSans(
                color: kMainColor,
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        );
        await Future.delayed(Duration(seconds: 2))
            .then((value) => btnController.reset());
      }
    }
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

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    rePasswordController.dispose();
    super.dispose();
  }
}
