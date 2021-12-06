import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:happy_care/core/themes/colors.dart';
import 'package:sizer/sizer.dart';

SnackBar customSnackBar({required String message, bool isError = false}) {
  return SnackBar(
    backgroundColor: kBackgroundColor,
    content: Text(
      message,
      style: GoogleFonts.openSans(
        color: isError ? kErorColor : kMainColor,
        fontSize: 10.sp,
        fontWeight: FontWeight.bold,
      ),
    ),
    duration: Duration(seconds: 1),
  );
}
