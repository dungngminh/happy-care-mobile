import 'package:get/get.dart';
import 'package:happy_care/data/repositories/user_repository.dart';

class MainController extends GetxController {
  var currentIndex = 0.obs;
  var role = "".obs;

  void changeCurrentIndex(int newIndex) {
    currentIndex.value = newIndex;
  }

  UserRepository? userRepository;

  MainController({this.userRepository});

  @override
  Future<void> onInit() async {
    super.onInit();
    await userRepository?.getUserData().then((value) => role.value = value.role);
  }

}
