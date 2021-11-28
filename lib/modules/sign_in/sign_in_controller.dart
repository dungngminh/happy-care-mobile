import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:happy_care/core/themes/colors.dart';
import 'package:happy_care/data/repositories/user_repository.dart';
import 'package:happy_care/routes/app_pages.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

class SignInController extends GetxController {
  var isHidePassword = true.obs;
  final UserRepository repository = UserRepository();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final RoundedLoadingButtonController btnController =
      RoundedLoadingButtonController();

  turnOnOffHiddenPassword() {
    isHidePassword.value = !isHidePassword.value;
    // btnController.reset();
    update();
  }

  Future<void> signIn(BuildContext context) async {
    if (emailController.text.isEmpty || passwordController.text.isEmpty) {
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
      bool isOK = await repository.signIn(
          email: emailController.text, password: passwordController.text);
      if (isOK) {
        btnController.success();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: kBackgroundColor,
            content: Text(
              "Đăng nhập thành công",
              style: GoogleFonts.openSans(
                color: kMainColor,
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        );
        await Future.delayed(Duration(seconds: 2))
            .then((value) => Get.toNamed(AppRoutes.rMain));
      } else {
        btnController.error();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: kBackgroundColor,
            content: Text(
              "Sai tài khoản hoặc mật khẩu",
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

  resetValue() {
    isHidePassword.value = true;
    emailController.text = "";
    passwordController.text = "";
    update();
  }
}
