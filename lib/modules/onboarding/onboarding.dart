import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:happy_care/core/themes/colors.dart';
import 'package:happy_care/widgets/onboarding_custom.dart';
import 'package:onboarding/onboarding.dart';

class OnboardingScreen extends StatelessWidget {
  OnboardingScreen({Key? key}) : super(key: key);
  final onboardingPagesList = [
    PageModel(
      widget: OnboardingCustom(
        pathSvg: 'assets/images/undraw_doctors_hwty.svg',
        title: 'Tư vấn sức khỏe ngay tại nhà với bác sĩ, chuyên gia',
        description: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. '
            'Nunc vestibulum volutpat consequat curabitur aliquam sagittis elementum feugiat. Libero sed.',
      ),
    ),
    PageModel(
      widget: OnboardingCustom(
        isFirstPage: false,
        pathSvg: 'assets/images/undraw_medical_research_qg4d.svg',
        title: 'Giải đáp thắc mắc liên quan tới sức khỏe',
        description: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. '
            'Nunc vestibulum volutpat consequat curabitur aliquam sagittis elementum feugiat. Libero sed.',
      ),
    ),
    PageModel(
      widget: OnboardingCustom(
        isFirstPage: false,
        pathSvg: 'assets/images/undraw_medicine_b1ol.svg',
        title: 'Giải đáp thắc mắc liên quan tới sức khỏe',
        description: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. '
            'Nunc vestibulum volutpat consequat curabitur aliquam sagittis elementum feugiat. Libero sed.',
      ),
    ),
    PageModel(
      widget: OnboardingCustom(
        isFirstPage: false,
        pathSvg: 'assets/images/undraw_doctor_kw5l.svg',
        title: 'Giải đáp thắc mắc liên quan tới sức khỏe',
        description: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. '
            'Nunc vestibulum volutpat consequat curabitur aliquam sagittis elementum feugiat. Libero sed.',
      ),
    )
  ];
  @override
  Widget build(BuildContext context) {
    return Onboarding(
      background: kBackgroundColor,
      proceedButtonStyle: ProceedButtonStyle(
        proceedButtonPadding:
            EdgeInsets.symmetric(horizontal: 17.0, vertical: 1.7),
        proceedButtonColor: kMainColor,
        proceedpButtonText: Text(
          "Đăng nhập",
          style: GoogleFonts.poppins(
            color: Colors.white,
            fontSize: 15,
            letterSpacing: 1.0,
          ),
        ),
        proceedButtonRoute: (context) {
          return Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => Container(),
            ),
            (route) => false,
          );
        },
      ),
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
    );
  }
}

