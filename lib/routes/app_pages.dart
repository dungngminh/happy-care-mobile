import 'package:get/get.dart';
import 'package:happy_care/modules/chat/chat_room/chat_room.dart';
import 'package:happy_care/modules/chat/chat_room/chat_room_binding.dart';
import 'package:happy_care/modules/chat/search/search.dart';
import 'package:happy_care/modules/chat/search/search_binding.dart';
import 'package:happy_care/modules/home/choose_doctor/choose_doctor.dart';
import 'package:happy_care/modules/home/choose_doctor/choose_doctor_binding.dart';
import 'package:happy_care/modules/main_screen/main_binding.dart';
import 'package:happy_care/modules/main_screen/main_screen.dart';
import 'package:happy_care/modules/onboarding/onboarding.dart';
import 'package:happy_care/modules/prescription/detail_prescription/detail_prescription.dart';
import 'package:happy_care/modules/prescription/detail_prescription/detail_prescription_binding.dart';
import 'package:happy_care/modules/prescription/edit_prescription/edit_prescription.dart';
import 'package:happy_care/modules/prescription/edit_prescription/edit_prescription_binding.dart';
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
      transition: Transition.downToUp,
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
      transition: Transition.downToUp,
    ),
    GetPage(
      name: AppRoutes.rEdit,
      binding: EditInformationBinding(),
      page: () => EditInformationScreen(),
    ),
    GetPage(
      name: AppRoutes.rSearch,
      binding: SearchBinding(),
      page: () => SearchScreen(),
    ),
    GetPage(
      name: AppRoutes.rChatRoom,
      binding: ChatRoomBinding(),
      page: () => ChatRoomScreen(),
    ),
    GetPage(
      name: AppRoutes.rListDoctor,
      binding: ChooseDoctorBinding(),
      page: () => ChooseDoctor(),
    ),
    GetPage(
      name: AppRoutes.rDetailPrescription,
      binding: DetailPrescriptionBinding(),
      page: () => DetailPrescription(),
    ),
    GetPage(
      name: AppRoutes.rEditPrescription,
      binding: EditPrescriptionBinding(),
      page: () => EditPrescriptionScreen(),
    ),
  ];
}
