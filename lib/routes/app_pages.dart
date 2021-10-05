import 'package:get/get.dart';
import 'package:happy_care/modules/onboarding/onboarding.dart';
import 'package:happy_care/modules/sign_in/sign_in.dart';
import 'package:happy_care/modules/sign_in/sign_in_binding.dart';

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
    // GetPage(
    //   name: AppRoutes.rSignUp,
    //   page: () {},
    // ),
    // GetPage(
    //   name: AppRoutes.rHome,
    //   page: () {},
    // ),
    // GetPage(
    //   name: AppRoutes.rChat,
    //   page: () {},
    // ),
    // GetPage(
    //   name: AppRoutes.rChat,
    //   page: () {},
    // ),
  ];
}
