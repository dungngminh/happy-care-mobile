import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:happy_care/core/themes/colors.dart';

class LogoTitle extends StatelessWidget {
  const LogoTitle({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
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
    );
  }
}
