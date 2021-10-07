import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignInController extends GetxController {
  var isHidePassword = true.obs;

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  turnOnOffHiddenPassword() {
    isHidePassword.value = !isHidePassword.value;
    update();
  }

  resetValue() {
    isHidePassword.value = true;
    emailController.text = "";
    passwordController.text = "";
    update();
  }

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}
