import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:happy_care/core/themes/colors.dart';
import 'package:happy_care/modules/sign_in/sign_in_controller.dart';
import 'package:happy_care/routes/app_pages.dart';
import 'package:happy_care/widgets/logo_title.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:sizer/sizer.dart';

class SignInScreen extends GetView<SignInController> {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(top: 5.8.h, left: 9.w, right: 9.w),
            child: Column(
              children: [
                LogoTitle(),
                SizedBox(
                  height: 35.h,
                  width: 100.w,
                  child: SvgPicture.asset("assets/images/Medicine-cuate.svg"),
                ),
                Row(
                  children: [
                    SizedBox(
                      width: 1.5.w,
                    ),
                    Text(
                      "Đăng nhập".toUpperCase(),
                      style: GoogleFonts.openSans(
                        fontSize: 18.sp,
                        color: kMainColor,
                        fontWeight: FontWeight.w800,
                        letterSpacing: 1,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 1.2.h,
                ),
                SizedBox(
                  height: 50,
                  width: double.infinity,
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                      color: kSecondColor,
                    ),
                    child: TextFormField(
                      controller: controller.emailController,
                      style: GoogleFonts.openSans(
                        color: kMainColor,
                        fontWeight: FontWeight.w600,
                        textBaseline: TextBaseline.alphabetic,
                      ),
                      textInputAction: TextInputAction.next,
                      onFieldSubmitted: (value) =>
                          controller.passFocus.requestFocus(),
                      textAlignVertical: TextAlignVertical.center,
                      decoration: InputDecoration(
                        fillColor: kMainColor,
                        prefixIcon: Icon(
                          Icons.person,
                          color: kMainColor,
                        ),
                        hintText: 'Email...',
                        contentPadding: const EdgeInsets.only(right: 40),
                        border: InputBorder.none,
                        hintStyle: GoogleFonts.openSans(
                          color: kMainColor,
                          fontWeight: FontWeight.w500,
                          textBaseline: TextBaseline.alphabetic,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 1.2.h,
                ),
                SizedBox(
                  height: 50,
                  width: double.infinity,
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                      color: kSecondColor,
                    ),
                    child: Stack(
                      children: [
                        Obx(
                          () => TextFormField(
                              controller: controller.passwordController,
                              style: GoogleFonts.openSans(
                                color: kMainColor,
                                fontWeight: FontWeight.w600,
                                textBaseline: TextBaseline.alphabetic,
                              ),
                              focusNode: controller.passFocus,
                              textAlignVertical: TextAlignVertical.center,
                              obscureText: controller.isHidePassword.value,
                              decoration: InputDecoration(
                                fillColor: kMainColor,
                                prefixIcon: Icon(
                                  Icons.lock,
                                  color: kMainColor,
                                ),
                                hintText: 'Password...',
                                contentPadding:
                                    const EdgeInsets.only(right: 40),
                                border: InputBorder.none,
                                hintStyle: GoogleFonts.openSans(
                                  color: kMainColor,
                                  fontWeight: FontWeight.w500,
                                  textBaseline: TextBaseline.alphabetic,
                                ),
                              ),
                              onFieldSubmitted: (value) {
                                controller.btnController.start();
                              }),
                        ),
                        GestureDetector(
                          onTap: () {
                            print("password hide on off");
                            controller.turnOnOffHiddenPassword();
                          },
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: Padding(
                              padding: const EdgeInsets.only(right: 16.0),
                              child: Obx(
                                () => Icon(
                                  controller.isHidePassword.value
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                  color: kMainColor,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 2.h,
                ),
                RoundedLoadingButton(
                  borderRadius: 35,
                  height: 55,
                  width: 330,
                  color: kMainColor,
                  successColor: kMainColor,
                  controller: controller.btnController,
                  onPressed: () => controller.signIn(context),
                  child: Text(
                    "Đăng nhập".toUpperCase(),
                    style: GoogleFonts.openSans(
                      color: Colors.white,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(height: 2.3.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Bạn là người dùng mới ?",
                      style: GoogleFonts.openSans(
                        color: kMainColor,
                        fontSize: 11.sp,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        print("TO SIGN UP");
                        controller.resetValue();

                        Get.toNamed(AppRoutes.rSignUp);
                      },
                      child: Text(
                        " Đăng ký",
                        style: GoogleFonts.openSans(
                          color: kMainColor,
                          fontSize: 11.sp,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 1.2.h,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: Row(
                    children: [
                      Expanded(
                        child: Divider(
                          thickness: 0.5,
                          color: kMainColor,
                          height: 2,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 2.w),
                        child: Text(
                          "Hoặc".toUpperCase(),
                          style: GoogleFonts.openSans(
                            color: kMainColor,
                            fontWeight: FontWeight.w400,
                            fontSize: 11.sp,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Divider(
                          thickness: 0.5,
                          color: kMainColor,
                          height: 2,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 1.2.h),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 26.w),
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(3),
                        height: 5.5.h,
                        width: 5.5.h,
                        child: SvgPicture.asset("assets/logos/google.svg"),
                      ),
                      Spacer(),
                      Container(
                        padding: const EdgeInsets.all(3),
                        height: 5.5.h,
                        width: 5.5.h,
                        child:
                            SvgPicture.asset("assets/logos/facebook-logo.svg"),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
