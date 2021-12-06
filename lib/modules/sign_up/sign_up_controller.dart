import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:happy_care/core/utils/validator.dart';
import 'package:happy_care/data/repositories/user_repository.dart';
import 'package:happy_care/widgets/custom_snack_bar.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

class SignUpController extends GetxController {
  //obs variable
  final isHidePassword = true.obs;
  final isHideRepassword = true.obs;
  File? profileImage;

  //controller
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final rePasswordController = TextEditingController();
  final btnController = RoundedLoadingButtonController();

  final passFocus = FocusNode();
  final rePassFocus = FocusNode();

  //repository
  final UserRepository? userRepository;

  SignUpController({this.userRepository});

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
        customSnackBar(
            message: "Vui lòng điền đầy đủ thông tin", isError: true),
      );
      await Future.delayed(Duration(seconds: 2))
          .then((value) => btnController.reset());
    } else if (!ValidatorUtils.checkEmail(emailController.text)) {
      btnController.error();
      ScaffoldMessenger.of(context).showSnackBar(
        customSnackBar(message: "Email không hợp lệ", isError: true),
      );
      await Future.delayed(Duration(seconds: 2))
          .then((value) => btnController.reset());
    } else if (passwordController.text.compareTo(rePasswordController.text) !=
        0) {
      btnController.error();
      ScaffoldMessenger.of(context).showSnackBar(
        customSnackBar(
            message: "Nhập lại mật khẩu không trùng với mật khẩu đã nhập",
            isError: true),
      );
      await Future.delayed(Duration(seconds: 2))
          .then((value) => btnController.reset());
    } else if (!ValidatorUtils.checkPassword(passwordController.text)) {
      btnController.error();
      ScaffoldMessenger.of(context).showSnackBar(
        customSnackBar(
            message:
                "Mật khẩu phải có ít nhất 1 chữ in hoa, 1 chữ thường, 1 chữ số",
            isError: true),
      );
      await Future.delayed(Duration(seconds: 2))
          .then((value) => btnController.reset());
    } else {
      bool isOK = await userRepository!.createNewUser(
          email: emailController.text, password: passwordController.text);
      if (isOK) {
        btnController.success();
        await Future.delayed(Duration(seconds: 1)).then((value) => Get.back());
        ScaffoldMessenger.of(context)
            .showSnackBar(customSnackBar(message: "Đăng nhập thành công"));
      } else {
        btnController.error();
        ScaffoldMessenger.of(context).showSnackBar(
          customSnackBar(
            message: "Đăng ký không thành công, vui lòng thử lại",
            isError: true,
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
