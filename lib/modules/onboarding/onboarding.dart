import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:happy_care/core/themes/colors.dart';
import 'package:happy_care/core/utils/shared_pref.dart';
import 'package:happy_care/routes/app_pages.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:sizer/sizer.dart';

class OnboardingScreen extends StatelessWidget {
  OnboardingScreen({Key? key}) : super(key: key);

  final listPage = <PageViewModel>[
    PageViewModel(
      titleWidget: Text(
        'Tư vấn sức khỏe tại nhà với bác sĩ, chuyên gia',
        textAlign: TextAlign.center,
        style: GoogleFonts.openSans(
          color: kMainColor,
          fontSize: 18.sp,
          fontWeight: FontWeight.w700,
        ),
      ),
      image: SizedBox(
        height: 30.h,
        width: 100.w,
        child: SvgPicture.asset(
          'assets/images/undraw_doctors_hwty.svg',
        ),
      ),
      bodyWidget: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Text(
          'Ngay tại nhà với chiếc điện thoại, bạn có thể được tư vấn sức khỏe '
          'với các bác sĩ, chuyên gia chuyên khoa.',
          style: GoogleFonts.openSans(
            fontSize: 11.sp,
          ),
          textAlign: TextAlign.justify,
        ),
      ),
    ),
    PageViewModel(
      titleWidget: Text(
        'Giải đáp thắc mắc liên quan tới sức khỏe',
        textAlign: TextAlign.center,
        style: GoogleFonts.openSans(
          color: kMainColor,
          fontSize: 18.sp,
          fontWeight: FontWeight.w700,
        ),
      ),
      image: SizedBox(
        height: 30.h,
        width: 100.w,
        child: SvgPicture.asset(
          'assets/images/undraw_medical_research_qg4d.svg',
        ),
      ),
      bodyWidget: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Text(
          'Các bác sĩ, chuyên gia sẽ giải đáp các thắc mắc của bạn liên quan tới sức khỏe '
          'Đưa ra những lời khuyên giúp bạn hiểu rõ hơn về tình trạng, sức khỏe của bạn hiện tại',
          style: GoogleFonts.openSans(
            fontSize: 11.sp,
          ),
          textAlign: TextAlign.justify,
        ),
      ),
    ),
    PageViewModel(
      titleWidget: Text(
        'Đưa ra\nđơn thuốc hiệu quả',
        textAlign: TextAlign.center,
        style: GoogleFonts.openSans(
          color: kMainColor,
          fontSize: 18.sp,
          fontWeight: FontWeight.w700,
        ),
      ),
      image: SizedBox(
        height: 30.h,
        width: 100.w,
        child: SvgPicture.asset(
          'assets/images/undraw_medicine_b1ol.svg',
        ),
      ),
      bodyWidget: Text(
        'Các bác sĩ, chuyên gia có thể sẽ cung cấp cho bạn đơn thuốc với các triệu chứng lâm sàng '
        'Đảm bảo sức khỏe của bạn nhanh chóng với những triệu chứng rõ ràng.',
        style: GoogleFonts.openSans(
          fontSize: 11.sp,
        ),
        textAlign: TextAlign.justify,
      ),
    ),
    PageViewModel(
      titleWidget: Text(
        'Đội ngũ\nbác sĩ, chuyên gia uy tín',
        textAlign: TextAlign.center,
        style: GoogleFonts.openSans(
          color: kMainColor,
          fontSize: 18.sp,
          fontWeight: FontWeight.w700,
        ),
      ),
      image: SizedBox(
        height: 30.h,
        width: 100.w,
        child: SvgPicture.asset(
          'assets/images/undraw_doctor_kw5l.svg',
        ),
      ),
      bodyWidget: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Text(
          'Happy Care mang tới bạn đội ngũ bác sĩ, chuyên gia từ các bệnh viện uy tín.'
          ' Giúp những lời khuyên, đơn thuốc mà đội ngũ mang tới đáng tin cậy cho sức khỏe của bạn',
          style: GoogleFonts.openSans(
            fontSize: 11.sp,
          ),
          textAlign: TextAlign.justify,
        ),
      ),
    )
  ];

  @override
  Widget build(BuildContext context) {
    return IntroductionScreen(
      pages: listPage,
      onDone: () async {
        await SharedPrefUtils.setBoolKey('first_time', false);
        Get.offAndToNamed(AppRoutes.rSignIn);
      },
      onSkip: () async {
        await SharedPrefUtils.setBoolKey('first_time', false);
        Get.offAndToNamed(AppRoutes.rSignIn);
      },
      color: kMainColor,
      showSkipButton: true,
      skip: Text(
        'Bỏ qua',
        style: GoogleFonts.openSans(
          fontWeight: FontWeight.w600,
          color: kMainColor,
        ),
      ),
      next: Text(
        'Tiếp theo',
        style: GoogleFonts.openSans(
          fontWeight: FontWeight.w600,
          color: kMainColor,
        ),
      ),
      done: Text(
        'Đăng nhập',
        style: GoogleFonts.openSans(
          fontWeight: FontWeight.w600,
          color: kMainColor,
        ),
      ),
      curve: Curves.fastLinearToSlowEaseIn,
      dotsDecorator: DotsDecorator(
        activeColor: kMainColor,
        size: Size(10.0, 10.0),
        color: Color(0xFFBDBDBD),
        activeSize: Size(22.0, 10.0),
        activeShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(25.0)),
        ),
      ),
      controlsPadding: EdgeInsets.only(bottom: 3.h),
    );
  }
}
