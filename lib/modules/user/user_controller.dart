import 'package:get/get.dart';
import 'package:happy_care/data/repositories/user_repository.dart';
import 'package:happy_care/routes/app_pages.dart';

class UserController extends GetxController {
  Rx<int> index = 0.obs;

  final UserRepository _userRepository = UserRepository();

  Future<void> signOut() async {
    await _userRepository.signOut();
    Get.offAndToNamed(AppRoutes.rSignIn);
  }

  void updateIndex() {
    index.value++;
    update();
  }
}
