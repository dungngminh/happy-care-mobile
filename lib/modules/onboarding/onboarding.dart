import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:happy_care/core/themes/colors.dart';
import 'package:happy_care/core/utils/shared_pref.dart';
import 'package:happy_care/modules/onboarding/widget/onboarding_custom.dart';
import 'package:happy_care/routes/app_pages.dart';
import 'package:onboarding/onboarding.dart';

class OnboardingScreen extends StatelessWidget {
  OnboardingScreen({Key? key}) : super(key: key);
  final onboardingPagesList = [
    PageModel(
      widget: OnboardingCustom(
        pathSvg: 'assets/images/undraw_doctors_hwty.svg',
        title: 'Tư vấn sức khỏe tại nhà với bác sĩ, chuyên gia',
        description:
            'Ngay tại nhà với chiếc điện thoại, bạn có thể được tư vấn sức khỏe '
            'với các bác sĩ, chuyên gia chuyên khoa.',
      ),
    ),
    PageModel(
      widget: OnboardingCustom(
        isFirstPage: false,
        pathSvg: 'assets/images/undraw_medical_research_qg4d.svg',
        title: 'Giải đáp thắc mắc liên quan tới sức khỏe',
        description:
            'Các bác sĩ, chuyên gia sẽ giải đáp các thắc mắc của bạn liên quan tới sức khỏe '
            'Đưa ra những lời khuyên giúp bạn hiểu rõ hơn về tình trạng, sức khỏe của bạn hiện tại',
      ),
    ),
    PageModel(
      widget: OnboardingCustom(
        isFirstPage: false,
        pathSvg: 'assets/images/undraw_medicine_b1ol.svg',
        title: 'Đưa ra\nđơn thuốc hiệu quả',
        description:
            'Các bác sĩ, chuyên gia có thể sẽ cung cấp cho bạn đơn thuốc với các triệu chứng lâm sàng '
            'Đảm bảo sức khỏe của bạn nhanh chóng với những triệu chứng rõ ràng.',
      ),
    ),
    PageModel(
      widget: OnboardingCustom(
        isFirstPage: false,
        pathSvg: 'assets/images/undraw_doctor_kw5l.svg',
        title: 'Đội ngũ\nbác sĩ, chuyên gia uy tín',
        description:
            'Happy Care mang tới bạn đội ngũ bác sĩ, chuyên gia từ các bệnh viện uy tín.'
            'Giúp những lời khuyên, đơn thuốc mà đội ngũ mang tới đáng tin cậy cho sức khỏe của bạn',
      ),
    )
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Onboarding(
        background: kBackgroundColor,
        proceedButtonStyle: ProceedButtonStyle(
            proceedButtonPadding:
                EdgeInsets.symmetric(horizontal: 17.0, vertical: 1.7),
            proceedButtonColor: kMainColor,
            proceedpButtonText: Text(
              "Đăng nhập",
              style: GoogleFonts.openSans(
                color: Colors.white,
                fontSize: 16,
                letterSpacing: 1.0,
              ),
            ),
            proceedButtonRoute: (context) async {
              await SharedPrefUtils.setBoolKey('first_time', false);
              Get.offAndToNamed(AppRoutes.rSignIn);
            }),
        isSkippable: false,
        pages: onboardingPagesList,
        indicator: Indicator(
          indicatorDesign: IndicatorDesign.polygon(
            polygonDesign: PolygonDesign(
              polygon: DesignType.polygon_circle,
            ),
          ),
          activeIndicator: ActiveIndicator(
            color: kMainColor,
          ),
          closedIndicator: ClosedIndicator(color: kMainColor),
        ),
        //-------------Other properties--------------
        //Color background,
        //EdgeInsets pagesContentPadding
        //EdgeInsets titleAndInfoPadding
        //EdgeInsets footerPadding
        //SkipButtonStyle skipButtonStyle
      ),
    );
  }
}
