import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:happy_care/core/themes/colors.dart';
import 'package:happy_care/widgets/logo_title.dart';
import 'package:sizer/sizer.dart';

class OnboardingCustom extends StatelessWidget {
  const OnboardingCustom({
    Key? key,
    required this.pathSvg,
    this.isFirstPage = true,
    required this.title,
    required this.description,
  }) : super(key: key);
  final String pathSvg;
  final bool isFirstPage;
  final String title;
  final String description;

  @override
  Widget build(BuildContext context) {
    print(MediaQuery.of(context).size);
    return Container(
      // padding: const EdgeInsets.symmetric(horizontal: 30),
      margin: const EdgeInsets.only(top: 20),
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            if (isFirstPage)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: LogoTitle(),
              ),
            SizedBox(
              height: isFirstPage ? 2.5.h : 10.h,
            ),
            SizedBox(
              height: 30.h,
              width: 100.w,
              child: SvgPicture.asset(
                pathSvg,
              ),
            ),
            SizedBox(
              height: 5.h,
            ),
            Text(
              title,
              textAlign: TextAlign.center,
              style: GoogleFonts.openSans(
                color: kMainColor,
                fontSize: 18.sp,
                fontWeight: FontWeight.w700,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              description,
              style: GoogleFonts.openSans(
                fontSize: 11.sp,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
