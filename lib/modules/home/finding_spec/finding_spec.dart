import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:happy_care/core/themes/colors.dart';
import 'package:happy_care/data/models/specialization.dart';
import 'package:happy_care/routes/app_pages.dart';
import 'package:sizer/sizer.dart';

class FindingSpecScreen extends StatelessWidget {
  FindingSpecScreen({Key? key}) : super(key: key);

  final List<Specialization> listSpecFound =
      Get.arguments as List<Specialization>;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              IconButton(
                onPressed: () => Get.back(),
                icon: Icon(
                  Icons.arrow_back,
                  color: kMainColor,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Center(
                  child: Text(
                    "Kết quả tìm được từ triệu chứng của bạn",
                    style: GoogleFonts.openSans(
                      color: kMainColor,
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 1.2.h),
              Center(
                child: Text(
                  "Đã tìm thấy ${listSpecFound.length} chuyên khoa bạn cần",
                  style: GoogleFonts.openSans(
                    color: kMainColor,
                    fontSize: 11.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              Divider(
                color: kMainColor,
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: listSpecFound.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: ListTile(
                        onTap: () => Get.toNamed(
                          AppRoutes.rListDoctor,
                          arguments: listSpecFound[index].name,
                        ),
                        title: Text(
                          listSpecFound[index].name,
                          style: GoogleFonts.openSans(
                            color: kMainColor,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        subtitle: Text(
                          listSpecFound[index].description!,
                          style: GoogleFonts.openSans(
                            color: kMainColor,
                          ),
                        ),
                        leading: CircleAvatar(
                          radius: 30,
                          backgroundColor: kMainColor,
                          child: Padding(
                            padding: const EdgeInsets.all(2.0),
                            child: CircleAvatar(
                              radius: 30,
                              backgroundColor: Colors.white,
                              backgroundImage:
                                  Image.asset("assets/images/doctor.png").image,
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
