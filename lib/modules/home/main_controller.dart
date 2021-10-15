import 'package:get/get.dart';
import 'package:happy_care/data/repositories/user_repository.dart';
import 'package:happy_care/routes/app_pages.dart';

class MainController extends GetxController {
  int currentIndex = 0;

  final UserRepository _userRepository = UserRepository();

  Future<void> signOut() async {
    await _userRepository.signOut();
    Get.offAndToNamed(AppRoutes.rSignIn);
  }

  void changeCurrentIndex(int newIndex) {
    currentIndex = newIndex;
    update();
  }
}
