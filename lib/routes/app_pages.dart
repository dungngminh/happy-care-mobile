import 'package:get/get.dart';
import 'package:happy_care/core/presentation/onboarding.dart';

part 'app_routes.dart';

// ignore: avoid_classes_with_only_static_members
class AppPages {
  static const initial = AppRoutes.rOnboarding;

  static final routes = [
    GetPage(
      name: AppRoutes.rOnboarding,
      page: () => OnboardingScreen(),
    ),
    // GetPage(
    //   name: AppRoutes.rSignIn,
    //   page: () {},
    // ),
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
