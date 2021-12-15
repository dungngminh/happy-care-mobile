import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:happy_care/core/themes/colors.dart';
import 'package:happy_care/data/models/user.dart';
import 'package:sizer/sizer.dart';

class DoctorDetailScreen extends StatelessWidget {
  const DoctorDetailScreen(
      {Key? key, required this.doctor, required this.function})
      : super(key: key);

  final User doctor;
  final VoidCallback function;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: 45.h,
                    width: double.infinity,
                    padding: const EdgeInsets.only(top: 16.0, left: 16.0),
                    decoration: BoxDecoration(
                      color: kMainColor,
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CircleAvatar(
                          backgroundColor: Colors.white24,
                          child: IconButton(
                            splashRadius: 24,
                            color: Colors.white,
                            onPressed: () => Get.back(),
                            icon: Icon(Icons.arrow_back),
                          ),
                        ),
                        Expanded(
                          child: Center(
                            child: CachedNetworkImage(
                              imageUrl: doctor.profile!.avatar!,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding:
                        const EdgeInsets.only(top: 8.0, left: 20, right: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          doctor.background!.first.degree! +
                              " " +
                              doctor.profile!.fullname!,
                          style: GoogleFonts.openSans(
                            color: kMainColor,
                            fontSize: 18.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          height: 0.5.h,
                        ),
                        Text(
                          doctor.specializations!.first +
                              " - " +
                              doctor.background!.first.workLocation!,
                          style: GoogleFonts.openSans(
                            color: Colors.grey.shade600,
                            fontSize: 14.sp,
                          ),
                        ),
                        SizedBox(
                          height: 2.5.h,
                        ),
                        Text(
                          "Giới thiệu",
                          style: GoogleFonts.openSans(
                            color: kMainColor,
                            fontSize: 13.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          height: 0.8.h,
                        ),
                        Text(
                          doctor.background!.first.gioithieu!,
                          style: GoogleFonts.openSans(
                            color: Colors.grey.shade600,
                            fontSize: 11.sp,
                          ),
                          textAlign: TextAlign.justify,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: GestureDetector(
                  onTap: function,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                      color: kMainColor,
                    ),
                    height: 8.h,
                    child: Center(
                      child: Text(
                        "Trò chuyện với bác sĩ",
                        style: GoogleFonts.openSans(
                          fontSize: 13.sp,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
