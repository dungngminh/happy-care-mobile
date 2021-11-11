import 'package:get/get.dart';
import 'package:happy_care/modules/main_screen/main_binding.dart';
import 'package:happy_care/modules/main_screen/main_screen.dart';
import 'package:happy_care/modules/onboarding/onboarding.dart';
import 'package:happy_care/modules/sign_in/sign_in.dart';
import 'package:happy_care/modules/sign_in/sign_in_binding.dart';
import 'package:happy_care/modules/sign_up/sign_up.dart';
import 'package:happy_care/modules/sign_up/sign_up_binding.dart';
import 'package:happy_care/modules/user/edit_information/edit_infomation.dart';
import 'package:happy_care/modules/user/edit_information/edit_information_binding.dart';

part 'app_routes.dart';

class AppPages {
  static const initial = AppRoutes.rOnboarding;
  static final routes = [
    GetPage(
      name: AppRoutes.rOnboarding,
      page: () => OnboardingScreen(),
    ),
    GetPage(
      name: AppRoutes.rSignIn,
      binding: SignInBinding(),
      page: () => SignInScreen(),
    ),
    GetPage(
      name: AppRoutes.rSignUp,
      binding: SignUpBinding(),
      page: () => SignUpScreen(),
    ),
    GetPage(
      name: AppRoutes.rMain,
      binding: MainBinding(),
      page: () => MainScreen(),
    ),
    GetPage(
      name: AppRoutes.rEdit,
      binding: EditInformationBinding(),
      page: () => EditInformationScreen(),
    ),
    // GetPage(
    //   name: AppRoutes.rChat,
    //   page: () {},
    // ),
  ];
}
