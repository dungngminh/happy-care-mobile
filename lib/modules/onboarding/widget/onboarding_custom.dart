import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:happy_care/core/themes/colors.dart';
import 'package:happy_care/widgets/logo_title.dart';

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
    return Container(
      // padding: const EdgeInsets.symmetric(horizontal: 30),
      margin: const EdgeInsets.only(top: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          if (isFirstPage)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: LogoTitle(),
            ),
          SizedBox(
            height: isFirstPage ? 10 : 73,
          ),
          SizedBox(
            height: 228,
            width: 312,
            child: SvgPicture.asset(
              pathSvg,
            ),
          ),
          SizedBox(
            height: 37,
          ),
          Text(
            title,
            textAlign: TextAlign.center,
            style: GoogleFonts.openSans(
              color: kMainColor,
              fontSize: 24,
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(
            height: 25,
          ),
          Text(
            description,
            style: GoogleFonts.openSans(
              fontSize: 15,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
