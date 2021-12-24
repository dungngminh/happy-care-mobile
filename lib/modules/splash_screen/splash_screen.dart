import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:happy_care/routes/app_pages.dart';
import 'package:happy_care/widgets/logo_title.dart';
import 'package:lottie/lottie.dart';
import 'package:sizer/sizer.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({
    Key? key,
    required this.isNotFirstTime,
    this.token,
  }) : super(key: key);

  final bool isNotFirstTime;
  final String? token;
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController =
        AnimationController(vsync: this, duration: Duration(seconds: 5));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 10.h),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  LogoTitle(),
                  Lottie.asset(
                    "assets/lottie/splash.json",
                    controller: _animationController,
                    height: 40.h,
                    animate: true,
                    onLoaded: (composition) {
                      _animationController
                        ..duration = composition.duration
                        ..forward().whenComplete(() {
                          Get.offNamed(
                            widget.isNotFirstTime
                                ? AppRoutes.rOnboarding
                                : (widget.token != null
                                    ? AppRoutes.rMain
                                    : AppRoutes.rSignIn),
                          );
                        });
                    },
                  ),
                ],
              ),
              Row(children: [
                Spacer(),
                CircleAvatar(
                    backgroundImage:
                        Image.asset("assets/images/icon.png").image),
                SizedBox(
                  width: 3.w,
                ),
                Text(
                  "KomKat",
                  style: GoogleFonts.openSans(
                    color: Color(0xFF917456),
                    fontSize: 14.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Spacer(),
              ]),
            ],
          ),
        ),
      ),
    );
  }
}
