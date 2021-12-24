import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:happy_care/core/themes/colors.dart';
import 'package:sizer/sizer.dart';

showConfirmDialog(BuildContext context,
    {required String title,
    required String contentDialog,
    required void Function() confirmFunction}) async {
  return await showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: Text(
        title,
        style: GoogleFonts.openSans(fontWeight: FontWeight.w600),
      ),
      content: Text(
        contentDialog,
      ),
      actions: [
        TextButton(
          onPressed: confirmFunction,
          child: Text(
            "Xác nhận",
            style: GoogleFonts.openSans(color: kMainColor),
          ),
        ),
        TextButton(
          onPressed: () => Get.back(result: false),
          child: Text(
            "Không",
            style: GoogleFonts.openSans(color: kMainColor),
          ),
        ),
      ],
    ),
  );
}

showLoadingDialog(BuildContext context, {required String contentDialog}) {
  return showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircularProgressIndicator(
                color: kMainColor,
              ),
              SizedBox(
                height: 1.2.h,
              ),
              Text(contentDialog,
                  style: GoogleFonts.openSans(
                      color: Colors.white, fontWeight: FontWeight.w700)),
            ],
          ),
        );
      });
}
