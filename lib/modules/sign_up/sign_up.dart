import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:happy_care/core/themes/colors.dart';
import 'package:happy_care/modules/sign_up/sign_up_controller.dart';
import 'package:happy_care/routes/app_pages.dart';
import 'package:happy_care/widgets/logo_title.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

class SignUpScreen extends GetWidget<SignUpController> {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 45, left: 40, right: 40),
          child: Column(
            children: [
              LogoTitle(),
              SizedBox(height: 42),
              Stack(
                children: [
                  SizedBox(
                    height: 145,
                    width: 145,
                    child: CircleAvatar(
                      backgroundColor: kMainColor,
                      child: SizedBox(
                        height: 134,
                        width: 134,
                        child: GetBuilder<SignUpController>(builder: (context) {
                          return controller.profileImage == null
                              ? CircleAvatar(
                                  backgroundColor: kSecondColor,
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
                                          fontWeight: FontWeight.bold,
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
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16,
                                        ),
                                      ),
                                    ),
                                    ListTile(
                                      onTap: () =>
                                          controller.removeProfileImage(),
                                      leading:
                                          Icon(Icons.delete, color: kMainColor),
                                      title: Text(
                                        "Xóa ảnh",
                                        style: GoogleFonts.openSans(
                                          color: kMainColor,
                                          fontWeight: FontWeight.bold,
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
                height: 35,
              ),
              Row(
                children: [
                  SizedBox(
                    width: 5,
                  ),
                  Text(
                    "Đăng ký".toUpperCase(),
                    style: GoogleFonts.openSans(
                      fontSize: 24,
                      color: kMainColor,
                      fontWeight: FontWeight.w800,
                      letterSpacing: 1,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 12),
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
                      textAlignVertical: TextAlignVertical.center,
                      decoration: InputDecoration(
                        fillColor: kMainColor,
                        prefixIcon: Icon(
                          Icons.person,
                          color: kMainColor,
                        ),
                        hintText: 'Email...',
                        contentPadding: const EdgeInsets.only(right: 32),
                        border: InputBorder.none,
                        hintStyle: GoogleFonts.openSans(
                          color: kMainColor,
                          fontWeight: FontWeight.w500,
                          textBaseline: TextBaseline.alphabetic,
                        ),
                      ),
                    ),
                  )),
              SizedBox(
                height: 12,
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
                      Obx(() => TextFormField(
                            controller: controller.passwordController,
                            style: GoogleFonts.openSans(
                              color: kMainColor,
                              fontWeight: FontWeight.w600,
                              textBaseline: TextBaseline.alphabetic,
                            ),
                            textAlignVertical: TextAlignVertical.center,
                            obscureText: controller.isHidePassword.value,
                            decoration: InputDecoration(
                              fillColor: kMainColor,
                              prefixIcon: Icon(
                                Icons.lock,
                                color: kMainColor,
                              ),
                              hintText: 'Password...',
                              contentPadding: const EdgeInsets.only(right: 40),
                              border: InputBorder.none,
                              hintStyle: GoogleFonts.openSans(
                                color: kMainColor,
                                fontWeight: FontWeight.w500,
                                textBaseline: TextBaseline.alphabetic,
                              ),
                            ),
                          )),
                      GestureDetector(
                        onTap: () {
                          print("password hide on off");
                          controller.turnOnOffHiddenPassword();
                        },
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: Padding(
                            padding: const EdgeInsets.only(right: 16.0),
                            child: Obx(() => Icon(
                                  controller.isHidePassword.value
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                  color: kMainColor,
                                )),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 12,
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
                      Obx(() => TextFormField(
                            controller: controller.rePasswordController,
                            style: GoogleFonts.openSans(
                              color: kMainColor,
                              fontWeight: FontWeight.w600,
                              textBaseline: TextBaseline.alphabetic,
                            ),
                            textAlignVertical: TextAlignVertical.center,
                            obscureText: controller.isHideRepassword.value,
                            decoration: InputDecoration(
                              fillColor: kMainColor,
                              prefixIcon: Icon(
                                Icons.lock,
                                color: kMainColor,
                              ),
                              hintText: 'Nhập lại password...',
                              contentPadding: const EdgeInsets.only(right: 40),
                              border: InputBorder.none,
                              hintStyle: GoogleFonts.openSans(
                                color: kMainColor,
                                fontWeight: FontWeight.w500,
                                textBaseline: TextBaseline.alphabetic,
                              ),
                            ),
                          )),
                      GestureDetector(
                        onTap: () {
                          print("repassword hide on off");
                          controller.turnOnOffHiddenRepassword();
                        },
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: Padding(
                            padding: const EdgeInsets.only(right: 16.0),
                            child: Obx(() => Icon(
                                  controller.isHideRepassword.value
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                  color: kMainColor,
                                )),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              RoundedLoadingButton(
                borderRadius: 35,
                height: 55,
                width: double.infinity,
                color: kMainColor,
                successColor: kMainColor,
                controller: controller.btnController,
                onPressed: () => controller.createNewUser(context),
                child: Text(
                  "Đăng ký".toUpperCase(),
                  style: GoogleFonts.openSans(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(height: 18),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Bạn đã có tài khoản ?",
                    style: GoogleFonts.openSans(
                      color: kMainColor,
                      fontSize: 15,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      print("tap");
                      Get.offNamed(AppRoutes.rSignIn);
                    },
                    child: Text(
                      " Đăng nhập",
                      style: GoogleFonts.openSans(
                        color: kMainColor,
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 13,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 80.0),
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
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: Text(
                        "Hoặc".toUpperCase(),
                        style: GoogleFonts.poppins(
                          color: kMainColor,
                          fontWeight: FontWeight.w400,
                          fontSize: 13,
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
              SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 110.0),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(3),
                      height: 40,
                      width: 40,
                      child: SvgPicture.asset("assets/logos/google.svg"),
                    ),
                    Spacer(),
                    Container(
                      padding: const EdgeInsets.all(3),
                      height: 40,
                      width: 40,
                      child: SvgPicture.asset("assets/logos/facebook-logo.svg"),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
