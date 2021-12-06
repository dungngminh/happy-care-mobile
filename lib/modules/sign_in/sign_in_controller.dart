import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:happy_care/core/utils/validator.dart';
import 'package:happy_care/data/repositories/user_repository.dart';
import 'package:happy_care/routes/app_pages.dart';
import 'package:happy_care/widgets/custom_snack_bar.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

class SignInController extends GetxController {
  var isHidePassword = true.obs;
  final UserRepository? userRepository;
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final btnController = RoundedLoadingButtonController();
  final passFocus = FocusNode();

  SignInController({this.userRepository});

  turnOnOffHiddenPassword() {
    isHidePassword.value = !isHidePassword.value;
    // btnController.reset();
    update();
  }

  Future<void> signIn(BuildContext context) async {
    btnController.start();
    if (emailController.text.isEmpty || passwordController.text.isEmpty) {
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
    } else if (ValidatorUtils.checkPassword(passwordController.text)) {
      btnController.error();
      ScaffoldMessenger.of(context).showSnackBar(
        customSnackBar(
            message:
                "Password phải có ít nhất 1 chữ in hoa, 1 chữ thường, 1 chữ số",
            isError: true),
      );
      await Future.delayed(Duration(seconds: 2))
          .then((value) => btnController.reset());
    } else {
      bool isOK = await userRepository!.signIn(
          email: emailController.text, password: passwordController.text);
      if (isOK) {
        btnController.success();
        ScaffoldMessenger.of(context).showSnackBar(
          customSnackBar(message: "Đăng nhập thành công"),
        );
        await Future.delayed(Duration(seconds: 2))
            .then((value) => Get.toNamed(AppRoutes.rMain));
      } else {
        btnController.error();
        ScaffoldMessenger.of(context).showSnackBar(
          customSnackBar(
              message: "Sai email hoặc mật khẩu, vui lòng kiểm tra lại",
              isError: true),
        );
        await Future.delayed(Duration(seconds: 2))
            .then((value) => btnController.reset());
      }
    }
  }

  resetValue() {
    isHidePassword.value = true;
    emailController.text = "";
    passwordController.text = "";
    update();
  }
}
