import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:happy_care/core/themes/colors.dart';
import 'package:happy_care/modules/sign_in/sign_in_controller.dart';

class SignInScreen extends StatelessWidget {
  SignInScreen({Key? key}) : super(key: key);

  final SignInController controller = Get.put(SignInController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // resizeToAvoidBottomInset: false,
      body: Padding(
        padding: const EdgeInsets.only(top: 35, left: 40, right: 40),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 5.0),
                    child: SvgPicture.asset("assets/logos/happy_care.svg"),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    "Happy Care".toUpperCase(),
                    //TODO: spacing of title
                    style: GoogleFonts.openSans(
                      color: kMainColor,
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      shadows: [
                        Shadow(
                          offset: Offset(0, 4.0),
                          blurRadius: 10.0,
                          color: Colors.black.withOpacity(0.25),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 283,
                width: 317,
                child: SvgPicture.asset("assets/images/Medicine-cuate.svg"),
              ),
              Row(
                children: [
                  SizedBox(
                    width: 5,
                  ),
                  Text(
                    "Đăng nhập".toUpperCase(),
                    style: GoogleFonts.openSans(
                      fontSize: 24,
                      color: kMainColor,
                      fontWeight: FontWeight.w800,
                      letterSpacing: 1,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 12,
              ),
              Container(
                height: 50,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                  color: kSecondColor,
                ),
                child: TextFormField(
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
              SizedBox(
                height: 12,
              ),
              Container(
                height: 50,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                  color: kSecondColor,
                ),
                child: Stack(
                  children: [
                    Obx(() => TextFormField(
                          style: GoogleFonts.openSans(
                            color: kMainColor,
                            fontWeight: FontWeight.w600,
                            textBaseline: TextBaseline.alphabetic,
                          ),
                          textAlignVertical: TextAlignVertical.center,
                          obscureText: controller.isHidePassword,
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
                                controller.isHidePassword
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
              SizedBox(
                height: 20,
              ),
              Container(
                height: 55,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: kMainColor,
                  borderRadius: BorderRadius.circular(25),
                ),
                child: Center(
                  child: Text(
                    "Đăng nhập".toUpperCase(),
                    style: GoogleFonts.openSans(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 18),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Bạn là người dùng mới ?",
                    style: GoogleFonts.openSans(
                      color: kMainColor,
                      fontSize: 15,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      print("tap");
                    },
                    child: Text(
                      " Đăng ký",
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
                      child: CircleAvatar(
                        backgroundColor: kSecondColor,
                        child: SvgPicture.asset("assets/logos/google.svg"),
                      ),
                    ),
                    Spacer(),
                    Container(
                      padding: const EdgeInsets.all(3),
                      height: 40,
                      width: 40,
                      child: CircleAvatar(
                        backgroundColor: kSecondColor,
                        child:
                            SvgPicture.asset("assets/logos/facebook-logo.svg"),
                      ),
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
